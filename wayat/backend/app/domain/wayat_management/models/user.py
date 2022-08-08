from typing import Optional

from pydantic import Field

from app.common.base.base_firebase_repository import BaseFirebaseModel


class UserEntity(BaseFirebaseModel):
    name: Optional[str]
    email: str
    phone: Optional[str]
    image_url: Optional[str]
    do_not_disturb: bool = False
    onboarding_completed: bool = False
    contacts: list = Field(default_factory=list)
