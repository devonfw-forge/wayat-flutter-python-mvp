import asyncio
import datetime

from fastapi import Depends
from google.cloud.firestore import GeoPoint

from app.domain.wayat_management.models.status import ContactRefInfo
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository


class MapService:
    def __init__(self,
                 user_repository: UserRepository = Depends(),
                 status_repository: StatusRepository = Depends()):
        self._user_repository = user_repository
        self._status_repository = status_repository

    async def update_location(self,
                              uid: str,
                              latitude: float,
                              longitude: float):
        await self._user_repository.update_user_location(uid, latitude, longitude)
        await self._update_contacts_status(uid, latitude, longitude)
        await self._update_contacts_mode(uid, latitude, longitude)

    async def _update_contacts_status(self, uid: str, latitude: float, longitude: float):
        self_user = await self._user_repository.get(uid)
        user_contacts_uids = self_user.contacts
        coroutines = [self._update_contact_status(uid, c, latitude, longitude) for c in user_contacts_uids]
        await asyncio.gather(*coroutines)

    async def _update_contact_status(self, uid: str, contact_uid: str, latitude: float, longitude: float):
        contact_status = await self._status_repository.get(contact_uid)
        old_contact_ref = set(filter(lambda x: x.uid != uid, contact_status.contact_refs))
        old_contact_ref.add(
            ContactRefInfo(uid=uid, last_updated=datetime.datetime.now(), location=GeoPoint(latitude, longitude))
        )
        await self._status_repository.update(
            data={"contacts_ref": old_contact_ref, "last_updated": datetime.datetime.now()},
            document_id=contact_uid
        )

    async def _update_contacts_mode(self, uid: str, latitude: float, longitude: float):
        # TO BE CONTINUED
        pass

