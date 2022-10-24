from fastapi import Depends

from app.common.infra.gcp.base_firebase_repository import BaseFirestoreRepository, get_async_client
from app.domain.counter_management.models.counter import CounterEntity
from google.cloud.firestore import Increment, AsyncClient  # type: ignore


class CounterRepository(BaseFirestoreRepository[CounterEntity]):
    def __init__(self, client: AsyncClient = Depends(get_async_client)):
        super(CounterRepository, self).__init__(collection_path="spike", model=CounterEntity, client=client)

    async def increment(self, value: int):
        await self.update(data={"value": Increment(value)}, document_id="counter_unprotected")
