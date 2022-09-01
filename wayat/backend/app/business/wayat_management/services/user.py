import asyncio
import logging
import mimetypes
from typing import BinaryIO, Optional

import requests
from fastapi import Depends
from requests import RequestException, Response

from app.business.wayat_management.models.group import GroupDTO, UsersListType
from app.business.wayat_management.models.user import UserDTO
from app.common.exceptions.http import NotFoundException
from app.common.infra.gcp.firebase import FirebaseAuthenticatedUser
from app.domain.wayat_management.utils import resize_image
from app.domain.wayat_management.models.user import UserEntity, GroupInfo
from app.domain.wayat_management.repositories.files import FileStorage, get_storage_settings, StorageSettings
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository

log = logging.getLogger(__name__)


class UserService:
    def __init__(self,
                 user_repository: UserRepository = Depends(),
                 status_repository: StatusRepository = Depends(),
                 file_repository: FileStorage = Depends(),
                 storage_settings: StorageSettings = Depends(get_storage_settings)):
        self._user_repository = user_repository
        self._status_repository = status_repository
        self._file_repository = file_repository
        self.DEFAULT_PICTURE = storage_settings.default_picture
        self.DEFAULT_GROUP_PICTURE = storage_settings.default_picture
        self.THUMBNAIL_SIZE = storage_settings.thumbnail_size

    def map_to_dto(self, entity: UserEntity) -> UserDTO:
        return UserDTO(
            id=entity.document_id,
            name=entity.name,
            email=entity.email,
            phone=entity.phone,
            image_url=self._file_repository.generate_signed_url(entity.image_ref),
            do_not_disturb=entity.do_not_disturb,
            share_location=entity.share_location,
            onboarding_completed=entity.onboarding_completed,
        )

    def map_group_to_dto(self, entity: GroupInfo) -> GroupDTO:
        return GroupDTO(
            id=entity.id,
            name=entity.name,
            members=entity.contacts,
            image_url=self._file_repository.generate_signed_url(entity.image_ref),
        )

    async def get_or_create(self, uid: str, default_data: FirebaseAuthenticatedUser) -> tuple[UserDTO, bool]:
        user_entity = await self._user_repository.get(uid)
        new_user = False
        if user_entity is None:
            image_ref = await self._extract_picture(uid, default_data.picture)
            new_user = True
            user_entity = await self._user_repository.create(
                uid=uid,
                name=default_data.name,
                email=default_data.email,
                phone=default_data.phone,
                image_ref=image_ref
            )
            await self._status_repository.initialize(uid)
        return self.map_to_dto(user_entity), new_user

    async def find_by_phone(self, phones: list[str]):
        user_entities = await self._user_repository.find_by_phone(phones=phones)
        return list(map(self.map_to_dto, user_entities))

    async def update_user(self,
                          uid: str,
                          **kwargs
                          ):
        # Filter only valid keys
        valid_keys = {"name", "phone", "onboarding_completed", "share_location", "do_not_disturb"} & kwargs.keys()
        update_data = {key: kwargs[key] for key in valid_keys}

        # Update required fields only
        if update_data:
            await self._user_repository.update(document_id=uid, data=update_data)

    async def add_contacts(self, *, uid: str, users: list[str]):
        # Check new users existence
        contacts = await self.get_contacts(users)
        found_contacts: set[str] = {e.id for e in contacts}

        self_user = await self._user_repository.get_or_throw(uid)
        existing_contacts: set[str] = set(self_user.contacts)

        new_contacts = found_contacts.difference(existing_contacts)
        if new_contacts:
            await self._user_repository.create_friend_request(uid, list(new_contacts))

    async def get_user_contacts(self, uid: str):
        return list(map(self.map_to_dto, await self._user_repository.get_contacts(uid)))

    async def get_user_groups(self, uid: str) -> list[GroupDTO]:
        groups = await self._user_repository.get_user_groups(uid)
        return list(map(self.map_group_to_dto, groups))

    async def get_user_group(self, uid: str, group_id: str) -> GroupDTO:
        user_groups = await self._user_repository.get_user_groups(uid)
        found_group = None
        for g in user_groups:
            if g.id == group_id:
                found_group = g
                break
        if found_group is None:
            raise NotFoundException("Group Not Found")
        return self.map_group_to_dto(found_group)

    async def update_profile_picture(self, uid: str, extension: str, data: BinaryIO | bytes):
        await self._file_repository.delete_user_images(uid)
        image_ref = await self._upload_profile_picture(uid=uid, extension=extension, data=data)
        await self._user_repository.update(document_id=uid, data={"image_ref": image_ref})

    async def _upload_profile_picture(self, uid: str, extension: str, data: BinaryIO | bytes) -> str:
        file_name = uid + extension
        image_ref = await self._file_repository.upload_image(file_name, resize_image(data, self.THUMBNAIL_SIZE))
        return image_ref

    async def _extract_picture(self, uid: str, url: str | None) -> str | None:
        if not url:
            return self.DEFAULT_PICTURE

        loop = asyncio.get_event_loop()

        def sync_process() -> tuple[Response, str]:
            res = requests.get(url)
            if res.status_code != 200:
                raise RequestException
            ext = mimetypes.guess_extension(res.headers['Content-Type'])
            if not ext:
                raise RequestException
            return res, ext

        try:
            response, extension = await loop.run_in_executor(None, sync_process)
            picture = await self._upload_profile_picture(
                uid=uid,
                extension=extension,
                data=response.content
            )
        except RequestException:
            log.error(f"Couldn't extract an profile picture from a token picture URL. Falling back to default picture")
            picture = self.DEFAULT_PICTURE

        return picture

    async def get_contact(self, uid: str) -> UserDTO:
        """
        Returns user DTO
        """
        user = await self._user_repository.get_or_throw(uid)
        return self.map_to_dto(user)

    async def get_contacts(self, uids: list[str]) -> list[UserDTO]:
        coroutines = [self.get_contact(u) for u in uids]
        contacts_dtos: list[UserDTO] = await asyncio.gather(*coroutines)
        return contacts_dtos

    async def get_pending_friend_requests(self, uid) -> tuple[list[UserDTO], list[UserDTO]]:
        """
        Returns pending friend requests, received and sent
        """
        user = await self._user_repository.get_or_throw(uid)
        return await self.get_contacts(user.pending_requests), await self.get_contacts(user.sent_requests)

    async def cancel_friend_request(self, uid, contact_id):
        """
        Cancels a pending sent friend request
        """
        await self._user_repository.cancel_friend_request(sender_id=uid, receiver_id=contact_id)

    async def respond_friend_request(self, user_uid: str, friend_uid: str, accept: bool):
        """
        Responds a friend request by either accepting or denying it
        """
        await self._user_repository.respond_friend_request(self_uid=user_uid, friend_uid=friend_uid, accept=accept)

    async def delete_contact(self, user_id, contact_id):
        """
        Deletes a contact
        """
        await self._user_repository.delete_contact(user_id, contact_id)

    async def delete_account(self, user_id):
        await self._delete_all_contacts(user_id)
        await self._user_repository.delete(document_id=user_id)
        await self._status_repository.delete(document_id=user_id)

    async def _delete_all_contacts(self, user_id):
        """
        Deletes all contacts of a user
        """
        user = await self._user_repository.get_or_throw(user_id)
        coroutines = [self._user_repository.delete_contact(user_id, u) for u in user.contacts]
        await asyncio.gather(*coroutines)

    async def phone_in_use(self, phone: str):
        users = await self._user_repository.find_by_phone(phones=[phone])
        return len(users) > 0

    async def create_group(self, user: str, name: str, members: list[str]) -> str:
        """
        Creates a group and returns the assigned id
        """
        group: GroupInfo = await self._user_repository.create_group(user, name, members, self.DEFAULT_GROUP_PICTURE)
        return group.id

    async def update_group(self, user: str, id_group: str, name: Optional[str], members: Optional[UsersListType]):
        """
        Updates a group info
        """
        user_groups = await self._user_repository.get_user_groups(user)
        try:
            group = next(g for g in user_groups if g.id == id_group)
        except StopIteration:
            raise NotFoundException("Group Not Found")

        if name is not None:
            group.name = name
        if members is not None:
            group.contacts = members

        await self._user_repository.update_user_groups(user, user_groups)
