from typing import Optional

from fastapi import Depends
from google.cloud.firestore import AsyncClient

from app.common.base.base_firebase_repository import BaseFirestoreRepository, get_async_client
from app.domain.wayat_management.models.user import UserEntity


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
        stream = super()._get_collection_reference().where('phone', 'in', phones).stream()
        models = []
        for snapshot in stream:
            models.append(self._model(document_id=snapshot.id, **snapshot.to_dict()))
        return models

