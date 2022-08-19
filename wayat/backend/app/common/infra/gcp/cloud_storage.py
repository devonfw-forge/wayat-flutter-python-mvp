import asyncio
import datetime
import json
import mimetypes
from functools import lru_cache
from typing import BinaryIO

from google.cloud.storage import Client, Bucket
from pydantic import BaseSettings

from app.common.core.configuration import load_env_file_on_settings
from app.common.utils import get_current_time

class BaseStorageSettings(BaseSettings):
    credentials_file: str
    bucket: str
    images_path: str
    expiration_time: int

    class Config:
        env_prefix = "STORAGE_"
        env_file = "TEST.env"


@lru_cache
def get_storage_settings() -> BaseStorageSettings:
    return load_env_file_on_settings(BaseStorageSettings)


@lru_cache
def _get_account_info():
    with open(get_storage_settings().credentials_file) as f:
        return json.load(f)


def _get_storage_client():
    return Client.from_service_account_info(_get_account_info())


class CloudStorage:
    def __init__(self,
                 client: Client,
                 storage_config: BaseStorageSettings):
        self._client = client
        self._configuration = storage_config

    def _bucket(self) -> Bucket:
        return self._client.bucket(self._configuration.bucket)

    async def upload_image(self, filename: str, data: BinaryIO | bytes) -> str:
        def sync_upload():
            content_type = mimetypes.guess_type(filename)[0] or 'application/octet-stream'
            path = f"{self._configuration.images_path}/{filename}"
            blob = self._bucket().blob(path)
            if isinstance(data, bytes):
                blob.upload_from_string(data, content_type=content_type)
            else:
                blob.upload_from_file(data, content_type=content_type)
            return blob.name

        loop = asyncio.get_event_loop()

        return await loop.run_in_executor(
            executor=None,
            func=sync_upload
        )

    def generate_signed_url(self, reference: str | None):
        if reference:
            return self._bucket().blob(reference).generate_signed_url(expiration=self._expiration_time())
        else:
            return None

    def _expiration_time(self) -> datetime.datetime:
        return get_current_time() + datetime.timedelta(seconds=self._configuration.expiration_time)
