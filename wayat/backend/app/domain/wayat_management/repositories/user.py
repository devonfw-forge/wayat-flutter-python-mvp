from typing import Optional

from fastapi import Depends
from google.cloud.firestore import AsyncClient

from app.common.base.base_firebase_repository import BaseFirestoreRepository, _get_async_client
from app.domain.wayat_management.models.user import UserEntity


class UserRepository(BaseFirestoreRepository[UserEntity]):
    def __init__(self, client: AsyncClient = Depends(_get_async_client)):
        super(UserRepository, self).__init__(collection_path="users", model=UserEntity, client=client)

    async def create(self, *,
                     uid: str,
                     name: Optional[str],
                     surname: Optional[str],
                     email: Optional[str],
                     phone: Optional[str],
                     image_url: Optional[str]
                     ):
        entity = UserEntity(
            document_id=uid,
            name=name,
            surname=surname,
            email=email,
            phone=phone,
            image_url=image_url,
        )
        await self.add(model=entity)
        return entity
