import asyncio
import functools
import logging
from datetime import datetime, timezone, timedelta
from functools import lru_cache
from typing import overload

from fastapi import Depends
from pydantic import BaseSettings

from app.common.core.configuration import load_env_file_on_settings
from app.common.utils import haversine_distance, get_current_time
from app.domain.wayat_management.models.status import ContactRefInfo
from app.domain.wayat_management.models.user import UserEntity, Location
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository

logger = logging.getLogger(__name__)


class MapSettings(BaseSettings):
    update_threshold: int
    valid_until_threshold: int
    distance_threshold: float

    class Config:
        env_prefix = "MAP_"
        env_file = "TEST.env"


@lru_cache
def get_map_settings() -> MapSettings:
    return load_env_file_on_settings(MapSettings)


class MapService:
    def __init__(self,
                 user_repository: UserRepository = Depends(),
                 status_repository: StatusRepository = Depends(),
                 map_settings: MapSettings = Depends(get_map_settings)
                 ):
        self._user_repository = user_repository
        self._status_repository = status_repository
        # minimum seconds between updates
        self._update_threshold = map_settings.update_threshold
        # range (km) in which users become active
        self._distance_threshold = map_settings.distance_threshold
        # max ammount of time for which the map status is valid
        self._map_valid_until_threshold = map_settings.valid_until_threshold

    async def update_location(self,
                              uid: str,
                              latitude: float,
                              longitude: float):
        await self._user_repository.update_user_location(uid, latitude, longitude)
        await self._update_contacts_status(uid, latitude, longitude)

    async def update_map_status(self, uid: str, next_map_state: bool):
        if next_map_state is True:
            # open the map
            user_entity = await self._user_repository.get(uid)
            if not user_entity.map_open:
                # Map is currently closed and we are opening it
                await self._open_closed_map(user_entity)
            else:
                # Map is currently opened, we refresh the "map_valid_until" field
                await self._user_repository.update_map_info(
                    uid,
                    next_map_state,
                    get_current_time() + timedelta(seconds=self._map_valid_until_threshold)
                )
        else:
            # close the map
            await self._user_repository.update_map_info(uid, next_map_state)

    async def _open_closed_map(self, user_entity: UserEntity):
        await self._user_repository.update_map_info(
            uid=user_entity.document_id,
            map_open=True,
            map_valid_until=get_current_time() + timedelta(seconds=self._map_valid_until_threshold)
        )
        await self.regenerate_map_status(user=user_entity)
        await self._status_repository.set_active_batch(uid_list=user_entity.contacts, value=True)

    @overload
    async def regenerate_map_status(self, *, uid: str):
        ...

    @overload
    async def regenerate_map_status(self, *, user: UserEntity):
        ...

    async def regenerate_map_status(self, *, uid: str | None = None, user: UserEntity | None = None):
        # Overload handling
        user_to_update = await self._user_repository.get(uid) if uid else user
        if not user_to_update:
            return
        uid = user_to_update.document_id

        # Implementation
        new_contact_refs = await asyncio.gather(
            *[self._create_contact_ref(contact_uid) for contact_uid in user_to_update.contacts],
        )  # type: list[ContactRefInfo]

        await asyncio.gather(
            self._status_repository.set_contact_refs(uid, [ref for ref in new_contact_refs if ref is not None]),
            self._user_repository.update_last_status(uid),
        )

    async def _create_contact_ref(self, contact_uid: str) -> ContactRefInfo | None:
        contact_location = await self._user_repository.get_user_location(contact_uid)
        if contact_location is not None:
            return ContactRefInfo(uid=contact_uid, last_updated=contact_location.last_updated,
                                  location=contact_location.value)
        else:
            return None

    async def _update_contacts_status(self, uid: str, latitude: float, longitude: float):
        contacts_with_map_open = await self._user_repository.find_contacts_with_map_open(uid)
        contacts_in_range = [c for c in contacts_with_map_open if self._in_range(latitude, longitude, c.location)]

        # Update my active status if at least one friend is looking at me
        active_value = len(contacts_in_range) != 0
        await self._status_repository.set_active(uid, active_value)

        # Update all maps that point at me
        await asyncio.gather(
            *[self._update_contact_status(c) for c in contacts_with_map_open]
        )

    async def _update_contact_status(self, contact: UserEntity):
        if self._needs_update(contact.last_status_update):
            await self.regenerate_map_status(uid=contact.document_id)

    def _needs_update(self, last_updated: datetime):
        return (datetime.now(last_updated.tzinfo) - last_updated).seconds > self._update_threshold

    def _in_range(self, latitude: float, longitude: float, contact_location: Location):
        if contact_location is None or contact_location.value is None:
            return False
        location = contact_location.value
        distance = haversine_distance(latitude, longitude, location.latitude, location.longitude)
        logger.debug(f"Distance of {distance} calculated")
        return distance < self._distance_threshold
