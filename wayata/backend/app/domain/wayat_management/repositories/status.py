from fastapi import Depends

from app.common.base.base_firebase_repository import BaseFirestoreRepository, get_async_client
from app.domain.wayat_management.models.status import AppStatusEntity, ContactRefInfo
from google.cloud.firestore import AsyncClient


class StatusRepository(BaseFirestoreRepository[AppStatusEntity]):
    def __init__(self, client: AsyncClient = Depends(get_async_client)):
        super(StatusRepository, self).__init__(collection_path="status", model=AppStatusEntity, client=client)

    async def initialize(self, uid: str):
        await self.add(model=AppStatusEntity(document_id=uid))

    async def set_contact_refs(self, uid: str, contact_refs: list[ContactRefInfo]):
        await self.update(document_id=uid, data={
            "contact_refs": [contact.dict() for contact in contact_refs]
        })

    async def set_active(self, uid: str, value: bool, read_first=True):
        # TODO: Validate if read_first=True
        if read_first:
            current_status = await self.get(uid)
            if current_status is None or current_status.active == value:
                return
        await self.update(document_id=uid, data={"active": value})

    async def set_active_batch(self, uid_list: list[str], value: bool):
        chunk_max_size = 500
        chunks = [uid_list[i:i + chunk_max_size] for i in range(0, len(uid_list), chunk_max_size)]
        for chunk in chunks:
            batch = self._client.batch()
            for uid in chunk:
                ref = self._get_document_reference(uid)
                batch.update(ref, {"active": value})
            await batch.commit()
