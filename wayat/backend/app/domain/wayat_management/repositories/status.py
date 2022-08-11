from datetime import datetime

from fastapi import Depends

from app.common.base.base_firebase_repository import BaseFirestoreRepository, get_async_client
from app.common.utils import get_current_time
from app.domain.wayat_management.models.status import AppStatusEntity, ContactRefInfo
from google.cloud.firestore import AsyncClient


class StatusRepository(BaseFirestoreRepository[AppStatusEntity]):
    def __init__(self, client: AsyncClient = Depends(get_async_client)):
        super(StatusRepository, self).__init__(collection_path="status", model=AppStatusEntity, client=client)

    async def initialize(self, uid: str):
        await self.add(model=AppStatusEntity(document_id=uid))

    async def set_contact_refs(self, uid: str, contact_refs: list[ContactRefInfo]):
        await self.update(document_id=uid, data={
            "contact_refs": [contact.dict() for contact in contact_refs],
            "last_updated": get_current_time()
        })
