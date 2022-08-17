import json
from datetime import timedelta, datetime
from functools import lru_cache
from typing import BinaryIO

from fastapi import Depends
from google.cloud.storage import Client, Bucket
from pydantic import BaseSettings

from app.common.core.configuration import load_env_file_on_settings
from app.common.utils import get_current_time


class StorageSettings(BaseSettings):
    credentials_file: str
    bucket: str
    images_path: str
    expiration_time: int

    class Config:
        env_prefix = "STORAGE_"
        env_file = "TEST.env"


@lru_cache
def get_storage_settings() -> StorageSettings:
    return load_env_file_on_settings(StorageSettings)


@lru_cache
def _get_account_info():
    with open(get_storage_settings().credentials_file) as f:
        return json.load(f)


def _get_storage_client():
    return Client.from_service_account_info(_get_account_info())


class FileStorage:
    def __init__(self,
                 client: Client = Depends(_get_storage_client),
                 storage_config: StorageSettings = Depends(get_storage_settings),
                 ):
        self._client = client
        self._configuration = storage_config

    def _bucket(self) -> Bucket:
        return self._client.bucket(self._configuration.bucket)

    def upload_image(self, filename: str, data: BinaryIO | bytes, content_type: str) -> str:
        path = f"{self._configuration.images_path}/{filename}"
        blob = self._bucket().blob(path)
        if isinstance(data, bytes):
            blob.upload_from_string(data, content_type=content_type)
        else:
            blob.upload_from_file(data, content_type=content_type)
        return blob.name

    def generate_signed_url(self, reference: str | None):
        if reference:
            return self._bucket().blob(reference).generate_signed_url(expiration=self._expiration_time())
        else:
            return None

    def _expiration_time(self) -> datetime:
        return get_current_time() + timedelta(seconds=self._configuration.expiration_time)
