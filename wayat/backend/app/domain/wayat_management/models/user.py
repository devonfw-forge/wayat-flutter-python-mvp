from datetime import datetime
from typing import Optional

from pydantic import Field, BaseModel

from app.common.base.base_firebase_repository import BaseFirebaseModel, GeoPoint
from app.common.utils import get_current_time


class Location(BaseModel):
    last_updated: datetime
    value: GeoPoint


class ContactLocation(BaseModel):
    uid: str
    location: Location


class UserEntity(BaseFirebaseModel):
    # User info
    name: Optional[str]
    email: str
    phone: Optional[str]
    image_url: Optional[str]
    contacts: list = Field(default_factory=list)
    location: Optional[Location]

    # Privacy settings
    do_not_disturb: bool = False

    # Internal variables
    onboarding_completed: bool = False
    map_open: bool = False
    map_valid_until: datetime = Field(default_factory=get_current_time)
    last_status_update: datetime = Field(default_factory=get_current_time)
