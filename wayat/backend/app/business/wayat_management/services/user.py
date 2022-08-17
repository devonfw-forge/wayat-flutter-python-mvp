import asyncio
import functools
import logging
from typing import BinaryIO

import requests
from fastapi import Depends

from app.business.wayat_management.models.user import UserDTO
from app.common.infra.firebase import FirebaseAuthenticatedUser
from app.domain.wayat_management.models.user import UserEntity
from app.domain.wayat_management.repositories.file_storage import FileStorage
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository

log = logging.getLogger(__name__)


class UserService:
    def __init__(self,
                 user_repository: UserRepository = Depends(),
                 status_repository: StatusRepository = Depends(),
                 file_repository: FileStorage = Depends()):
        self._user_repository = user_repository
        self._status_repository = status_repository
        self._file_repository = file_repository

    def map_to_dto(self, entity: UserEntity) -> UserDTO:
        return None if entity is None else UserDTO(
            id=entity.document_id,
            name=entity.name,
            email=entity.email,
            phone=entity.phone,
            image_url=self._file_repository.generate_signed_url(entity.image_ref),
            do_not_disturb=entity.do_not_disturb,
            share_location=entity.share_location,
            onboarding_completed=entity.onboarding_completed,
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
        coroutines = [self._user_repository.get(u) for u in users]
        contacts_entities: list[UserEntity | None] = await asyncio.gather(*coroutines)
        found_contacts: set[str] = {e.document_id for e in contacts_entities if e is not None}

        self_user = await self._user_repository.get(uid)
        existing_contacts: set[str] = set(self_user.contacts)

        new_contacts = found_contacts.difference(existing_contacts)
        if new_contacts:
            await self._user_repository.create_friend_request(uid, list(new_contacts))

    async def get_contacts(self, uid):
        return list(map(self.map_to_dto, await self._user_repository.get_contacts(uid)))

    async def update_profile_picture(self, uid: str, content_type: str, data: BinaryIO | bytes):
        loop = asyncio.get_event_loop()

        image_ref = await loop.run_in_executor(
            executor=None,
            func=functools.partial(self._upload_profile_picture, uid=uid, content_type=content_type, data=data)
        )

        await self._user_repository.update(document_id=uid, data={"image_ref": image_ref})

    def _upload_profile_picture(self, uid: str, content_type: str, data: BinaryIO | bytes) -> str:
        if content_type == "image/jpeg":
            extension = ".jpeg"
        elif content_type == "image/png":
            extension = ".png"
        else:
            raise ValueError("Invalid content-type. Image must be in either JPEG or PNG format")
        file_name = uid + extension
        image_ref = self._file_repository.upload_image(file_name, data, content_type)
        return image_ref

    async def _extract_picture(self, uid: str, url: str) -> str | None:
        if not url:
            return None

        loop = asyncio.get_event_loop()

        def sync_process() -> str:
            response = requests.get(url)
            if response.status_code != 200:
                log.error(f"Couldn't extract profile picture from token. (Status code {response.status_code})")
                return ""
            else:
                return self._upload_profile_picture(
                    uid=uid,
                    content_type=response.headers.get("content-type", "undefined"),
                    data=response.content
                )

        return await loop.run_in_executor(None, sync_process)
