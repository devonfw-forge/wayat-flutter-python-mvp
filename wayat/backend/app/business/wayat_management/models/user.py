from typing import Optional, List, NewType
from pydantic import BaseModel

from app.common.base.base_entity import BaseCamelModel

IDType = NewType("IDType", str)


class UserID(BaseCamelModel):
    id: IDType


# Requests
class UpdateUserRequest(UserID):
    name: Optional[str]
    phone: Optional[str]
    surname: Optional[str]


class AddContactsRequest(BaseCamelModel):
    users: list[IDType]


class UpdateShareLocationRequest(BaseCamelModel):
    enable: bool


class UserDTO(UpdateUserRequest):
    email: str
    image_url: str
    do_not_disturb: bool


# Responses
class UserProfileResponse(UserDTO):
    pass


class UserWithPhoneResponse(UserID):
    phone: str
    name: str
    surname: Optional[str]
    image_url: str


class ListUsersWithPhoneResponse(BaseCamelModel):
    users: list[UserWithPhoneResponse]
