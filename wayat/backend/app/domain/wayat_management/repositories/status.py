from typing import AsyncIterable

from fastapi import Depends
from google.cloud.firestore import DocumentSnapshot

from app.common.infra.gcp.base_firebase_repository import BaseFirestoreRepository, get_async_client
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
            "contact_refs_members": [contact.uid for contact in contact_refs]
        })

    async def set_active(self, uid: str, value: bool):
        await self.update(document_id=uid, data={"active": value})

    async def set_active_batch(self, uid_list: list[str], value: bool):
        await self.update_batch(uid_list=uid_list, update={"active": value})

    async def find_maps_containing_user(self, uid: str) -> list[str]:
        """
        Given a User uid, returns a list of uids containing those Users whose map contains the initial User.
        :param uid: The User to search in the maps
        :return: A list of uids of Users that have the given uid in their map
        """
        result_stream = (
            self
            ._get_collection_reference()
            .where("contact_refs_members", "array_contains", uid)
            .stream()
        )  # type: AsyncIterable[DocumentSnapshot]
        return [document.id async for document in result_stream]
