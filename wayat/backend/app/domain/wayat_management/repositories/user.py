import asyncio
import datetime
from typing import Optional

from fastapi import Depends
from google.cloud.firestore import AsyncClient, GeoPoint

from app.common.base.base_firebase_repository import BaseFirestoreRepository, get_async_client
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
        contacts_entities: list[UserEntity] = await asyncio.gather(*coroutines)
        return contacts_entities

    async def update_user_location(self, uid: str, latitude: float, longitude: float) -> None:
        location: Location = Location(value=GeoPoint(latitude, longitude), last_updated=datetime.datetime.utcnow())
        await self.update(data={"location": location.dict()}, document_id=uid)

    async def get_user_location(self, uid: str) -> Location:
        user_entity = await self.get(uid)
        return user_entity.location
