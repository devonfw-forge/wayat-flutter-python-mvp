import logging
from typing import overload

from fastapi import Depends
import firebase_admin
from firebase_admin import messaging
from firebase_admin.messaging import Notification

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
    def _send_simple_notification(self, token: str, data: dict[str, str]) -> str:
        return messaging.send(message=messaging.Message(
            data=data,
            token=token
        ))

    @run_in_executor
    def _send_notification(self, token: str, notification: Notification):
        return messaging.Message(
            notification=notification,
            token=token
        )

    @overload
    async def send_notification(self, *, token: str, notification: Notification):
        ...

    @overload
    async def send_notification(self, *, token: str, data: dict[str, str]):
        ...

    async def send_notification(self, *, token: str, notification: Notification, data: dict[str, str]):
        # Overload handling
        if notification is not None:
            return await self._send_notification(token, notification)
        elif data is not None:
            return await self._send_simple_notification(token, data)
        else:
            raise ValueError("Either notification or data should not be None. Invalid parameters")


