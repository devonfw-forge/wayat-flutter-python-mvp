import asyncio
import logging
import mimetypes
from typing import BinaryIO, Optional, Tuple

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

    # Mappers Entity -> DTO

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

    # User Info

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

    async def delete_account(self, user_id):
        """
            Removes all contacts + User Document + User Status Document
        """
        await self._delete_all_contacts(user_id)
        await self._user_repository.delete(document_id=user_id)
        await self._status_repository.delete(document_id=user_id)

    # User Contacts

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

    @staticmethod
    def _remove_contact_from_all_groups(contact_id: str, groups: list[GroupInfo]):
        for g in groups:
            if contact_id in g.contacts:
                g.contacts.remove(contact_id)

    async def delete_contact(self, user_id, contact_id):
        """
        Deletes a contact
        """
        # Remove contact from all user groups
        user_groups, _ = await self._user_repository.get_user_groups(user_id)
        self._remove_contact_from_all_groups(contact_id, user_groups)
        # Remove user from all contact groups
        contact_groups, _ = await self._user_repository.get_user_groups(contact_id)
        self._remove_contact_from_all_groups(user_id, contact_groups)
        # Delete friend from user & contact
        await self._user_repository.delete_contact(user_id, contact_id)
        # Update user groups
        await self._user_repository.update_user_groups(user_id=user_id, user_groups=user_groups)
        # Update contact groups
        await self._user_repository.update_user_groups(user_id=contact_id, user_groups=contact_groups)

    async def _delete_all_contacts(self, user_id):
        """
            Deletes all contacts of a user
        """
        user = await self._user_repository.get_or_throw(user_id)
        for c in user.contacts:  # Classic loop to avoid concurrency problems
            await self.delete_contact(user_id, c)

    async def phone_in_use(self, phone: str) -> bool:
        users = await self._user_repository.find_by_phone(phones=[phone])
        return len(users) > 0

    # User Groups

    async def get_user_groups(self, uid: str) -> list[GroupDTO]:
        groups, _ = await self._user_repository.get_user_groups(uid)
        return list(map(self.map_group_to_dto, groups))

    async def _get_user_group(self, uid: str, group_id: str) -> Tuple[GroupInfo, list[GroupInfo], UserEntity]:
        user_groups, user_entity = await self._user_repository.get_user_groups(uid)
        try:
            group = next(g for g in user_groups if g.id == group_id)
        except StopIteration:
            raise NotFoundException("Group Not Found")
        return group, user_groups, user_entity

    async def get_user_group(self, uid: str, group_id: str) -> GroupDTO:
        group, _, _ = await self._get_user_group(uid, group_id)
        return self.map_group_to_dto(group)

    async def create_group(self, user: str, name: str, members: list[str]) -> str:
        """
        Creates a group and returns the assigned id
        """
        group: GroupInfo = await self._user_repository.create_group(user, name, members, self.DEFAULT_GROUP_PICTURE)
        return group.id

    async def delete_group(self, *, uid: str, group_id: str):
        _, groups, _ = await self._get_user_group(uid, group_id)
        groups = [g for g in groups if g.id != group_id]
        await self._user_repository.update_user_groups(user_id=uid, user_groups=groups)

    async def update_group(self, user: str, id_group: str, name: Optional[str] = None,
                           members: Optional[UsersListType] = None, image_ref: Optional[str] = None):
        """
        Updates a group info
        """
        group, user_groups, user_entity = await self._get_user_group(user, id_group)

        # Update Name of Group
        if name is not None:
            group.name = name

        # Update Members of Group (Validates are friends of user)
        if members is not None and set(members).issubset(set(user_entity.contacts)):
            group.contacts = members
        elif members is not None:
            raise NotFoundException(f"Trying to add a user that is not in your contacts list"
                                    f" {list(set(members).difference(set(user_entity.contacts)))}")
        # Update Image of Group
        if image_ref is not None:
            group.image_ref = image_ref

        await self._user_repository.update_user_groups(user, user_groups)

    # User & Group picture handling

    async def update_profile_picture(self, uid: str, extension: str, data: BinaryIO | bytes):
        user = await self._user_repository.get_or_throw(uid)
        if user.image_ref != self.DEFAULT_PICTURE:
            await self._file_repository.delete(reference=user.image_ref)
        image_ref = await self._upload_profile_picture(uid=uid, extension=extension, data=data)
        await self._user_repository.update(document_id=uid, data={"image_ref": image_ref})

    @staticmethod
    def _get_profile_picture_ref(uid: str, extension: str):
        return uid + extension

    async def _upload_profile_picture(self, uid: str, extension: str, data: BinaryIO | bytes) -> str:
        file_name = self._get_profile_picture_ref(uid, extension)
        image_ref = await self._file_repository.upload_profile_image(file_name, resize_image(data, self.THUMBNAIL_SIZE))
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

    @staticmethod
    def _get_group_image_ref(user: str, group_id: str, extension: str):
        return f"{user}_{group_id}{extension}"

    async def update_group_picture(self, *, user: str, group: str, picture: BinaryIO | bytes, extension: str):
        group_info, _, _ = await self._get_user_group(uid=user, group_id=group)
        if group_info.image_ref != self.DEFAULT_GROUP_PICTURE:
            await self._file_repository.delete(reference=group_info.image_ref)
        image_name = self._get_group_image_ref(user, group, extension)
        new_image = await self._file_repository.upload_group_image(filename=image_name,
                                                                   data=resize_image(picture, self.THUMBNAIL_SIZE))
        await self.update_group(user, group, image_ref=new_image)
