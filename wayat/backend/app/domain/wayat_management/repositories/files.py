import json
from functools import lru_cache
from typing import BinaryIO

from fastapi import Depends
from google.cloud.storage import Client
from app.common.core.configuration import load_env_file_on_settings
from app.common.infra.gcp.cloud_storage import BaseStorageSettings, CloudStorage
from app.common.infra.gcp.firebase import get_account_info


class StorageSettings(BaseStorageSettings):
    default_picture: str
    thumbnail_size: int
    profile_images_path: str
    group_images_path: str


@lru_cache
def get_storage_settings() -> StorageSettings:
    return load_env_file_on_settings(StorageSettings)


def _get_storage_client():
    return Client.from_service_account_info(get_account_info())


class FileStorage(CloudStorage):
    def __init__(self, client: Client = Depends(_get_storage_client),
                 storage_config: StorageSettings = Depends(get_storage_settings)):
        super().__init__(client, storage_config)
        self._client = client
        self._storage_config = storage_config

    # async def delete_user_images(self, uid: str):
    #     await self.delete(prefix=f"{self._storage_config.profile_images_path}/{uid}")

    async def upload_profile_image(self, filename: str, data: BinaryIO | bytes) -> str:
        return await self.upload_file(path=self._storage_config.profile_images_path, filename=filename, data=data)

    async def upload_group_image(self, filename: str, data: BinaryIO | bytes) -> str:
        return await self.upload_file(path=self._storage_config.group_images_path, filename=filename, data=data)
