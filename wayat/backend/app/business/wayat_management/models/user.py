from enum import Enum
from typing import Optional, NewType
from pydantic import BaseModel


class UserID(BaseModel):
    id: str


# Requests
class UpdateUserRequest(BaseModel):
    name: Optional[str]
    phone: Optional[str]
    phone_prefix: Optional[str]
    onboarding_completed: Optional[bool]
    share_location: Optional[bool]


class AddContactsRequest(BaseModel):
    users: list[str]


class FindByPhoneRequest(BaseModel):
    phones: list[str]


class UpdatePreferencesRequest(BaseModel):
    do_not_disturb: Optional[bool]
    share_location: Optional[bool]


class SetNotificationsTokenRequest(BaseModel):
    token: str


class UserDTO(UpdateUserRequest):
    email: str
    id: str
    image_url: Optional[str]
    share_location: bool
    do_not_disturb: bool
    onboarding_completed: bool


# Responses
class UserProfileResponse(UserDTO):
    new_user: bool


class UserWithPhoneResponse(UserID):
    phone: str
    phone_prefix: Optional[str]
    name: str
    image_url: str


class ListUsersWithPhoneResponse(BaseModel):
    users: list[UserWithPhoneResponse]


class UserWithSharingIndicator(UserWithPhoneResponse):
    share_location: bool


class ListUsersWithPhoneAndSharingIndicatorResponse(BaseModel):
    users: list[UserWithSharingIndicator]


class PendingFriendsRequestsResponse(BaseModel):
    sent_requests: list[UserWithPhoneResponse]
    pending_requests: list[UserWithPhoneResponse]


class HandleFriendRequestRequest(BaseModel):
    uid: str
    accept: bool


class UpdateContactPreferencesRequest(BaseModel):
    share_location: bool


class NotificationActionsType(str, Enum):
    ACCEPTED_FRIEND_REQUEST = "ACCEPTED_FRIEND_REQUEST"
    RECEIVED_FRIEND_REQUEST = "RECEIVED_FRIEND_REQUEST"


class NotificationData(BaseModel):
    action: NotificationActionsType
    contact_name: str


def dto_to_user_with_phone_response(u: UserDTO):
    return UserWithPhoneResponse(id=u.id, phone=u.phone, phone_prefix=u.phone_prefix, name=u.name,
                                 image_url=u.image_url)
