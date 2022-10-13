from datetime import datetime
from typing import Optional

from pydantic import Field, BaseModel

from app.common.infra.gcp.base_firebase_repository import BaseFirebaseModel, GeoPoint
from app.domain.wayat_management.utils import get_current_time


class Location(BaseModel):
    last_updated: datetime
    value: GeoPoint
    address: str


class ContactLocation(BaseModel):
    uid: str
    location: Location


class GroupInfo(BaseModel):
    id: str
    name: str
    image_ref: str
    contacts: list[str] = Field(default_factory=list)


class UserEntity(BaseFirebaseModel):
    # User info
    name: Optional[str]
    email: str
    phone: Optional[str]
    phone_prefix: Optional[str]
    image_ref: Optional[str]
    contacts: list[str] = Field(default_factory=list)
    location_shared_with: list[str] = Field(default_factory=list)
    sent_requests: list[str] = Field(default_factory=list)
    pending_requests: list[str] = Field(default_factory=list)
    location: Optional[Location]
    groups: list[GroupInfo] = Field(default_factory=list)
    notifications_tokens: list[str] = Field(default_factory=list)

    # Privacy settings
    share_location: bool = True
    do_not_disturb: bool = False

    # Internal variables
    onboarding_completed: bool = False
    map_open: bool = False
    active: bool = False
    map_valid_until: datetime = Field(default_factory=get_current_time)
    last_status_update: datetime = Field(default_factory=get_current_time)
