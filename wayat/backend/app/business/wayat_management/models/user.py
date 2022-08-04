from typing import Optional, NewType
from pydantic import BaseModel

IDType = NewType("IDType", str)


class UserID(BaseModel):
    id: IDType


# Requests
class UpdateUserRequest(UserID):
    name: Optional[str]
    phone: Optional[str]
    surname: Optional[str]


class AddContactsRequest(BaseModel):
    users: list[IDType]


class FindByPhoneRequest(BaseModel):
    phones: list[str]


class UpdatePreferencesRequest(BaseModel):
    do_not_disturb: bool


class UserDTO(UpdateUserRequest):
    email: str
    image_url: str
    do_not_disturb: bool


# Responses
class UserProfileResponse(UserDTO):
    new_user: bool


class UserWithPhoneResponse(UserID):
    phone: str
    name: str
    surname: Optional[str]
    image_url: str


class ListUsersWithPhoneResponse(BaseModel):
    users: list[UserWithPhoneResponse]
