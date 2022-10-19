import asyncio
import logging
from datetime import datetime, timedelta
from functools import lru_cache
from typing import overload, Optional, List

from fastapi import Depends
from pydantic import BaseSettings

from app.common.core.configuration import load_env_file_on_settings
from app.domain.wayat_management.utils import haversine_distance, get_current_time
from app.domain.wayat_management.models.status import ContactRefInfo
from app.domain.wayat_management.models.user import UserEntity, Location
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository

logger = logging.getLogger(__name__)


class MapSettings(BaseSettings):
    update_threshold: int
    valid_until_threshold: int
    distance_threshold: float
    max_time_without_update: int

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
        # max time since last location update
        self._max_time_since_last_update = map_settings.max_time_without_update

    async def update_location(self,
                              uid: str,
                              latitude: float,
                              longitude: float,
                              address: str,
                              ):
        logger.info(f"Updating location for user {uid}")
        await self._user_repository.update_user_location(uid, latitude, longitude, address)
        await self.update_contacts_status(uid, latitude, longitude)

    async def update_map_status(self, uid: str, next_map_state: bool):
        if next_map_state is True:
            # open the map
            user_entity = await self._user_repository.get_or_throw(uid)
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
        await self.force_status_update(user_entity=user_entity)

    async def force_status_update(self, *,
                                  uid: str | None = None,
                                  user_entity: UserEntity | None = None,
                                  force_contacts_active: bool = True):
        """
        Regenerates the User map. If force_contacts_update=True (default) all its contacts will become active,
        sending a location update as soon as possible.
        Either one of uid or user_entity must be provided. If both are passed, user_entity has precedence.
        :param uid: The uid of the User
        :param user_entity: The User entity
        :param force_contacts_active: Whether to set all of User's contacts to active mode.
        """
        if user_entity is not None:
            user_to_update = user_entity
        elif uid is not None:
            user_to_update = await self._user_repository.get_or_throw(uid)
        else:
            raise ValueError("Either uid or user_entity should not be None. Invalid parameters")
        await self.regenerate_map_status(user=user_to_update)
        if force_contacts_active:
            await self._set_active(uids=user_to_update.contacts, active=True)

    @overload
    async def regenerate_map_status(self, *, uid: str):
        ...

    @overload
    async def regenerate_map_status(self, *, user: UserEntity):
        ...

    async def regenerate_map_status(self, *, uid: str | None = None, user: UserEntity | None = None):
        # Overload handling
        if user is not None:
            user_to_update = user
        elif uid is not None:
            user_to_update = await self._user_repository.get_or_throw(uid)
        else:
            raise ValueError("Either uid or user_entity should not be None. Invalid parameters")

        uid = user_to_update.document_id

        # Implementation
        new_contact_refs = await asyncio.gather(
            *[self._create_contact_ref(contact_uid, user_to_update) for contact_uid in user_to_update.contacts],
        )  # type: list[ContactRefInfo]
        logger.info(f"Updating contact ref for {user_to_update.name} - {user_to_update.document_id}")
        await asyncio.gather(
            self._status_repository.set_contact_refs(uid, [ref for ref in new_contact_refs if ref is not None]),
            self._user_repository.update_last_status(uid),
        )

    async def _create_contact_ref(self, contact_uid: str, self_user: UserEntity) -> ContactRefInfo | None:
        contact_location, sharing_with = await self._user_repository.get_user_location(contact_uid)
        if contact_location is not None and \
                self._should_show(contact_location) and \
                self_user.document_id in sharing_with:
            return ContactRefInfo(uid=contact_uid, last_updated=contact_location.last_updated,
                                  location=contact_location.value, address=contact_location.address)
        else:
            return None

    async def update_contacts_status(self, uid: str, latitude: float = None, longitude: float = None, force=False):
        contacts, self_user = await self._user_repository.get_contacts(uid)
        contacts_map_open = [c for c in contacts if c.map_open is True and c.map_valid_until >= get_current_time()]
        contacts_map_open_self_share_location = [c for c in contacts_map_open
                                                 if c.document_id in self_user.location_shared_with
                                                 and self_user.share_location]
        # Update all maps that point at me
        logger.info("Updating maps pointing at me")
        await asyncio.gather(*[self._update_contact_status(c, force) for c in contacts_map_open_self_share_location])

        if latitude is None or longitude is None:
            if self_user.location is None:
                return
            long = self_user.location.value.longitude
            lat = self_user.location.value.latitude
        else:
            lat = latitude
            long = longitude

        contacts_in_range = [c for c in contacts if self._in_range(lat, long, c.location)]

        # Update my active status if at least one friend is looking at me
        contacts_self_sharing_location_with_and_map_open_in_range = list(
            set(
                [c.document_id for c in contacts_in_range]
            ).intersection(set(
                [c.document_id for c in contacts_map_open_self_share_location]
            ))
        )
        active_value = len(contacts_self_sharing_location_with_and_map_open_in_range) != 0
        logger.info(f"Contacts with map open in range {len(contacts_self_sharing_location_with_and_map_open_in_range)}")
        logger.info(f"Self status {self_user.active}")
        if active_value != self_user.active:  # Update my active status if changed only
            logger.info(f"Updating self status {active_value}")
            await self._set_active(uid=self_user.document_id, active=active_value)

        # Set active all contacts in range and sharing location with me which are not already active
        contacts_sharing_location_with_me = [c for c in contacts if self_user.document_id in c.location_shared_with
                                             and c.share_location]
        contacts_in_range_and_sharing_location_with_me_not_active = list(
            set(
                [c.document_id for c in contacts_in_range if c.active is False]
            ).intersection(set(
                [c.document_id for c in contacts_sharing_location_with_me]
            ))
        )
        logger.info(f"Contacts in range sharing location with me "
                    f"not active {len(contacts_in_range_and_sharing_location_with_me_not_active)}")
        await self._set_active(uids=contacts_in_range_and_sharing_location_with_me_not_active, active=True)

    @overload
    async def _set_active(self, *, uid: str, active: bool):
        ...

    @overload
    async def _set_active(self, *, uids: List[str], active: bool):
        ...

    async def _set_active(self, *, uid: str = None, uids: List[str] = None, active: bool):
        if uid is not None:
            logger.info(f"Setting active {uid} {active}")
            await self._status_repository.set_active(uid, active)
            await self._user_repository.set_active(uid, active)
        elif uids is not None:
            logger.info(f"Setting active {uids} {active}")
            if len(uids) > 0:
                await self._status_repository.set_active_batch(uid_list=uids, value=active)
                await self._user_repository.set_active_batch(uid_list=uids, value=active)
        else:
            raise ValueError("Either uid or uids should not be None. Invalid parameters")

    async def _update_contact_status(self, contact: UserEntity, force: bool):
        if force or self._needs_update(contact.last_status_update):
            logger.info(f"Updating contact status for {contact.document_id} - {force}")
            await self.regenerate_map_status(user=contact)

    def _needs_update(self, last_updated: datetime):
        return (get_current_time(last_updated.tzinfo) - last_updated).seconds > self._update_threshold

    def _should_show(self, location: Optional[Location]):
        if location is not None:
            return (get_current_time(location.last_updated.tzinfo) - location.last_updated).seconds \
                   < self._max_time_since_last_update
        else:
            return False

    def _in_range(self, latitude: float, longitude: float, contact_location: Optional[Location]):
        if contact_location is None or contact_location.value is None:
            return False
        location = contact_location.value
        distance = haversine_distance(latitude, longitude, location.latitude, location.longitude)
        logger.debug(f"Distance of {distance} calculated")
        return distance < self._distance_threshold

    async def regenerate_maps_containing_user(self, uid: str):
        coroutines = [self.regenerate_map_status(uid=contact_uid)
                      for contact_uid in await self._status_repository.find_maps_containing_user(uid)]
        await asyncio.gather(*coroutines)
