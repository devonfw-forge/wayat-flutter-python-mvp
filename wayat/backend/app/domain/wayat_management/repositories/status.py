from fastapi import Depends

from app.common.base.base_firebase_repository import BaseFirestoreRepository, get_async_client
from app.domain.wayat_management.models.status import AppStatusEntity
from google.cloud.firestore import AsyncClient


class StatusRepository(BaseFirestoreRepository[AppStatusEntity]):
    def __init__(self, client: AsyncClient = Depends(get_async_client)):
        super(StatusRepository, self).__init__(collection_path="status", model=AppStatusEntity, client=client)

    async def initialize(self, uid: str):
        await self.add(model=AppStatusEntity(document_id=uid))
