import asyncio
from datetime import datetime
from typing import Optional
from fastapi import Depends
from google.cloud.firestore import AsyncClient

from app.common.base.base_firebase_repository import BaseFirestoreRepository, get_async_client
from app.common.utils import get_current_time
from app.domain.wayat_management.models.user import UserEntity, Location


class UserRepository(BaseFirestoreRepository[UserEntity]):
    def __init__(self, client: AsyncClient = Depends(get_async_client)):
        super(UserRepository, self).__init__(collection_path="users", model=UserEntity, client=client)

    async def create(self, *,
                     uid: str,
                     name: Optional[str],
                     email: Optional[str],
                     phone: Optional[str],
                     image_url: Optional[str]
                     ):
        entity = UserEntity(
            document_id=uid,
            name=name,
            email=email,
            phone=phone,
            image_url=image_url,
        )
        await self.add(model=entity)
        return entity

    async def find_by_phone(self, *, phones: list[str]):
        return [item async for item in self.where("phone", 'in', phones)]

    async def get_contacts(self, uid: str):
        self_user = await self.get(uid)
        coroutines = [self.get(u) for u in self_user.contacts]
        contacts_entities: list[UserEntity] = await asyncio.gather(*coroutines)  # type: ignore
        return contacts_entities

    async def update_user_location(self, uid: str, latitude: float, longitude: float) -> None:
        location: Location = Location(
            value=(latitude, longitude),
            last_updated=get_current_time()
        )
        await self.update(data={"location": location.dict()}, document_id=uid)

    async def get_user_location(self, uid: str, force=False) -> Location | None:
        """
        Returns the location of a User. If force=False (default), this Location will be None if the User has the
        share_location property set to False.

        :param force: whether to ignore share_location or not
        :param uid: the UID of the User
        :return: the Location of the User, or None if it's not available
        """
        user_entity = await self.get(uid)
        if user_entity is None or user_entity.location is None:  # if not available, return None
            return None
        elif not force and not user_entity.share_location:  # if not forcing, decide on not(share_location)
            return None
        else:
            return user_entity.location

    async def find_contacts_with_map_open(self, uid: str) -> list[UserEntity]:
        result_stream = (
            self._get_collection_reference()
            .where("contacts", "array_contains", uid)
            .where("map_open", "==", True)
            .where("map_valid_until", ">", get_current_time())
            .stream()
        )
        return [self._model(document_id=result.id, **result.to_dict()) async for result in result_stream] # type: ignore

    async def update_last_status(self, uid: str):
        await self.update(document_id=uid, data={"last_status_update": get_current_time()})

    async def update_map_info(self, uid: str, map_open: bool, map_valid_until: datetime | None = None):
        data = {"map_open": map_open}
        if map_valid_until is not None:
            data["map_valid_until"] = map_valid_until
        await self.update(document_id=uid, data=data)
