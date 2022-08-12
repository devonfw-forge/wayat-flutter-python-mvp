import datetime
from typing import Optional

from google.cloud.firestore import GeoPoint as _GeoPoint
from pydantic import Field, BaseModel

from app.common.base.base_firebase_repository import BaseFirebaseModel


class GeoPoint(_GeoPoint):
    @classmethod
    def __get_validators__(cls):
        yield cls.validate_geopoint

    @classmethod
    def validate_geopoint(cls, value):
        if isinstance(value, _GeoPoint):
            return value
        if isinstance(value, dict):
            if 'latitude' not in value or 'longitude' not in value:
                return ValueError("'location' dictionary must contain both 'latitude' and 'longitude'")
            return cls(value["latitude"], value["longitude"])
        if isinstance(value, tuple):
            if len(value) != 2:
                return ValueError("'location' tuple must contain (latitude, longitude)")
            return cls(*value)

    @classmethod
    def __modify_schema__(cls, field_schema):
        # __modify_schema__ should mutate the dict it receives in place,
        # the returned value will be ignored
        field_schema.update(
            properties={
                'latitude': {'title': 'Latitude', 'type': 'float'},
                'longitude': {'title': 'Longitude', 'type': 'float'},
            }
        )

    def __repr__(self):
        return f"GeoPoint(longitude={self.longitude}, latitude={self.latitude})"
    

class Location(BaseModel):
    last_updated: datetime.datetime
    value: GeoPoint


class UserEntity(BaseFirebaseModel):
    name: Optional[str]
    email: str
    phone: Optional[str]
    image_url: Optional[str]
    do_not_disturb: bool = False
    share_location: bool = True
    onboarding_completed: bool = False
    contacts: list = Field(default_factory=list)
    map_open: bool = False
    location: Optional[Location]
