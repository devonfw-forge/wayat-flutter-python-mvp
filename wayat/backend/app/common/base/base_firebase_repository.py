import json
from functools import lru_cache
from typing import TypeVar, Generic, Type, overload, Any, AsyncGenerator

from fastapi import Depends
from google.cloud.firestore import AsyncClient, AsyncCollectionReference, AsyncDocumentReference
from pydantic import BaseModel

from app.common.infra import get_firebase_settings


class BaseFirebaseModel(BaseModel):
    document_id: str

    class Config:
        arbitrary_types_allowed = True
        extra = 'allow'


ModelType = TypeVar("ModelType", bound=BaseFirebaseModel)


def get_async_client():
    return AsyncClient.from_service_account_info(_get_account_info())


@lru_cache
def _get_account_info():
    with open(get_firebase_settings().credentials_file) as f:
        return json.load(f)


class BaseFirestoreRepository(Generic[ModelType]):
    def __init__(self, *,
                 collection_path: str | tuple[str],
                 model: Type[ModelType],
                 client: AsyncClient = Depends(get_async_client)):
        """
        Object with default methods to Create, Read, Update and Delete (CRUD) from a Firestore Collection.
        """
        self._client = client
        self._model = model
        self._path = collection_path if isinstance(collection_path, tuple) else tuple(collection_path.split("/"))

    def _get_collection_reference(self) -> AsyncCollectionReference:
        return self._client.collection(*self._path)

    def _get_document_reference(self, document_id: str) -> AsyncDocumentReference:
        return self._client.document(*self._path, document_id)

    async def get(self, document_id: str) -> ModelType | None:
        snapshot = await self._get_document_reference(document_id).get()
        return self._model(document_id=snapshot.id, **snapshot.to_dict()) if snapshot.exists else None

    async def add(self, *, model: ModelType):
        await self._get_document_reference(model.document_id).create(model.dict(exclude={"document_id"}))

    @overload
    async def update(self, *, model: ModelType):
        ...

    @overload
    async def update(self, *, data: dict[str, Any], document_id: str):
        ...

    async def update(self, *,
                     model: ModelType | None = None,
                     data: dict[str, Any] | None = None,
                     document_id: str | None = None):
        if model is not None:
            await self._get_document_reference(model.document_id).update(model.dict(exclude={"document_id"}))
        elif data is not None and document_id is not None:
            await self._get_document_reference(document_id).update(data)
        else:
            raise ValueError("Either model or (document_id, data) must be passed as argument")

    async def where(self, field: str, operation: str, value: Any) -> AsyncGenerator[ModelType, None]:
        all_generators = []

        def find(sublist: list[Any]):
            stream = self._get_collection_reference().where(field, operation, sublist).stream()
            return stream # .stream() returns AsyncGenerator in the async client

        if operation == 'in':
            residual = len(value) % 10
            num_iterations = len(value) // 10
            if residual > 0:
                num_iterations += 1
            for i in range(0, num_iterations):
                all_generators.append(find(value[i * 10:(i + 1) * 10]))
        else:
            all_generators = find(value)

        for generator in all_generators:
            async for item in generator:
                yield self._model(document_id=item.id, **item.to_dict())

    async def delete(self, *, model: ModelType | None = None, document_id: str | None = None):
        id_to_delete = document_id or (model.document_id if model else None)
        if not id_to_delete:
            raise ValueError("Either model or document_id must be passed as argument")
        await self._get_document_reference(document_id).delete()
