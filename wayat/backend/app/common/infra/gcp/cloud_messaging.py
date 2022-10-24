import logging
from typing import overload, Optional

import firebase_admin  # type: ignore
from fastapi import Depends
from firebase_admin import messaging
from firebase_admin.messaging import Notification, BatchResponse  # type: ignore

from app.common.infra import FirebaseSettings
from app.common.infra.gcp.utils import get_firebase_settings, run_in_executor

log = logging.getLogger(__name__)


class CloudMessaging:
    def __init__(self, settings: FirebaseSettings = Depends(get_firebase_settings)):
        try:
            self._client = firebase_admin.get_app()
        except ValueError as e:
            log.info(e)
            log.info("Initializing Firebase APP")
            firebase_credentials = firebase_admin.credentials.Certificate(settings.credentials_file)
            self._client = firebase_admin.initialize_app(credential=firebase_credentials)

    # https://github.com/firebase/firebase-admin-python/blob/5b7ac0558ef89cdd386daddaf55a3d5ee3122a72/snippets/messaging/cloud_messaging.py#L24-L40
    @run_in_executor
    def _send_simple_notification(self, tokens: list[str], data: dict[str, str]) -> BatchResponse:
        return messaging.send_all(messages=[messaging.Message(
            data=data,
            token=token
        ) for token in tokens])

    @run_in_executor
    def _send_notification(self, tokens: list[str], notification: Notification):
        return messaging.send_all(messages=[messaging.Message(
            notification=notification,
            token=token
        ) for token in tokens])

    @overload
    async def send_notification(self, *, tokens: list[str], notification: Notification):
        ...

    @overload
    async def send_notification(self, *, tokens: list[str], data: dict[str, str]):
        ...

    async def send_notification(self, *, tokens: list[str], notification: Optional[Notification] = None,
                                data: Optional[dict[str, str]] = None):
        # Overload handling
        if notification is not None:
            return await self._send_notification(tokens, notification)
        elif data is not None:
            return await self._send_simple_notification(tokens, data)
        else:
            raise ValueError("Either notification or data should not be None. Invalid parameters")


