import datetime

from google.cloud.firestore import GeoPoint
from pydantic import BaseModel, Field

from app.common.base.base_firebase_repository import BaseFirebaseModel


class ContactRefInfo(BaseModel):
    uid: str
    last_updated: datetime.datetime
    location: GeoPoint

    class Config:
        arbitrary_types_allowed = True


class AppStatusEntity(BaseFirebaseModel):
    active: bool = False
    last_updated: datetime.datetime = datetime.datetime.now()
    contact_refs: list[ContactRefInfo] = Field(default_factory=list)

