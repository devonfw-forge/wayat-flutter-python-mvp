import json
from functools import lru_cache

from fastapi import Depends
from google.cloud.storage import Client
from app.common.core.configuration import load_env_file_on_settings
from app.common.infra.gcp.cloud_storage import BaseStorageSettings, CloudStorage


class StorageSettings(BaseStorageSettings):
    default_picture: str
    thumbnail_size: int


@lru_cache
def get_storage_settings() -> StorageSettings:
    return load_env_file_on_settings(StorageSettings)


@lru_cache
def _get_account_info():
    with open(get_storage_settings().credentials_file) as f:
        return json.load(f)


def _get_storage_client():
    return Client.from_service_account_info(_get_account_info())


class FileStorage(CloudStorage):
    def __init__(self, client: Client = Depends(_get_storage_client),
                 storage_config: StorageSettings = Depends(get_storage_settings)):
        super().__init__(client, storage_config)
        self._client = client
