import asyncio
import functools
import json
from typing import ParamSpec, TypeVar, Callable, Awaitable

from pydantic import BaseSettings

from app.common.core.configuration import load_env_file_on_settings

P = ParamSpec("P")
R = TypeVar("R")


def run_in_executor(f: Callable[P, R]) -> Callable[P, Awaitable[R]]:
    async def async_f(*args: P.args, **kwargs: P.kwargs):
        loop = asyncio.get_event_loop()
        return await loop.run_in_executor(
            executor=None,
            func=functools.partial(f, *args, **kwargs)
        )

    return async_f


class FirebaseSettings(BaseSettings):
    credentials_file: str
    api_key: str

    class Config:
        env_prefix = "FIREBASE_"
        env_file = "TEST.env"


@functools.lru_cache
def get_account_info():
    with open(get_firebase_settings().credentials_file) as f:
        return json.load(f)


@functools.lru_cache
def get_firebase_settings() -> FirebaseSettings:
    return load_env_file_on_settings(FirebaseSettings)


