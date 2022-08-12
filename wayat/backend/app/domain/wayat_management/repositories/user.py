import asyncio
from typing import Optional
from fastapi import Depends
from google.cloud import firestore
from google.cloud.firestore import AsyncClient
from google.cloud.firestore_v1 import AsyncTransaction

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

    async def get_user_location(self, uid: str) -> Location | None:
        user_entity = await self.get(uid)
        return user_entity.location if user_entity else None

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

    async def create_friend_request(self, sender: str, receivers: list[str]):
        transaction = self._client.transaction()
        sender_ref = self._get_document_reference(sender)
        receivers_ref = [self._get_document_reference(u) for u in receivers]

        @firestore.async_transactional
        async def execute(t: AsyncTransaction):
            update_sender = {
                "sent_requests": firestore.ArrayUnion(receivers)
            }
            self._validate_update(update_sender)
            update_receivers = {
                "pending_requests": firestore.ArrayUnion([sender])
            }
            self._validate_update(update_receivers)
            t.update(sender_ref, update_sender)
            for r in receivers_ref:
                t.update(r, update_receivers)

        await execute(transaction)
