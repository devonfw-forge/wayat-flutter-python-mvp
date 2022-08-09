import datetime
from typing import Optional

from google.cloud.firestore import GeoPoint
from pydantic import Field, BaseModel

from app.common.base.base_firebase_repository import BaseFirebaseModel


class Location(BaseModel):
    last_updated: datetime.datetime
    value: GeoPoint

    class Config:
        arbitrary_types_allowed = True


class UserEntity(BaseFirebaseModel):
    name: Optional[str]
    email: str
    phone: Optional[str]
    image_url: Optional[str]
    do_not_disturb: bool = False
    onboarding_completed: bool = False
    contacts: list = Field(default_factory=list)
    map_open: bool = False
    location: Optional[Location]
