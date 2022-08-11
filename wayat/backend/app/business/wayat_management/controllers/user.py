import logging

from fastapi import APIRouter, Depends

from app.business.wayat_management.models.user import (
    UserProfileResponse,
    UpdateUserRequest,
    ListUsersWithPhoneResponse,
    FindByPhoneRequest,
    AddContactsRequest,
    UpdatePreferencesRequest, UserWithPhoneResponse, PendingFriendsRequestsResponse, HandleFriendRequestRequest,
)
from app.business.wayat_management.services.user import UserService
from app.common import get_user
from app.common.infra.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/users")

logger = logging.getLogger(__name__)


@router.get("/profile", description="Get a user profile", response_model=UserProfileResponse)
async def get_user_profile(user: FirebaseAuthenticatedUser = Depends(get_user()),
                           user_service: UserService = Depends()):
    logger.debug(f"Getting user profile with id {user.uid}")
    user_dto, new_user = await user_service.get_or_create(user.uid, user)
    return UserProfileResponse(**user_dto.dict(), new_user=new_user)


@router.post("/profile",
             description="Update a user profile, setting those values that were explicitly set, even if set to null")
async def update_user_profile(request: UpdateUserRequest,
                              user: FirebaseAuthenticatedUser = Depends(get_user()),
                              user_service: UserService = Depends()):
    logger.info(f"Updating {user.uid=} with values {request.dict(exclude_unset=True)}")
    await user_service.update_user(user.uid, **request.dict(exclude_unset=True))


@router.post("/profile/picture", description="Updates the user profile picture")
async def update_profile_picture(user: FirebaseAuthenticatedUser = Depends(get_user())):
    pass


@router.post("/find-by-phone",
             description="Get a list of users filtered by phone",
             response_model=ListUsersWithPhoneResponse,
             dependencies=[Depends(get_user())])
async def get_users_filtered(request: FindByPhoneRequest, user_service: UserService = Depends(UserService)):
    logger.debug(f"Getting contacts with phones {request.phones}")
    users = await user_service.find_by_phone(request.phones)
    users_phone = [UserWithPhoneResponse(id=u.id, phone=u.phone, name=u.name, image_url=u.image_url) for u in users]
    return ListUsersWithPhoneResponse(users=users_phone)


@router.post("/add-contact", description="Add a list of users to the contact list")
async def add_contact(request: AddContactsRequest, user_service: UserService = Depends(UserService),
                      user: FirebaseAuthenticatedUser = Depends(get_user())):
    logger.debug(f"Adding contacts {request.users}")
    await user_service.add_contacts(uid=user.uid, users=request.users)


@router.post("/preferences", description="Update the preferences of a user")
async def update_preferences(request: UpdatePreferencesRequest):
    # TODO
    pass


@router.get("/contacts", description="Get the list of contacts for a user", response_model=ListUsersWithPhoneResponse)
async def get_contacts(user: FirebaseAuthenticatedUser = Depends(get_user()),
                       user_service: UserService = Depends(UserService)):
    logger.debug(f"Getting contacts for user {user.uid}")
    cts = await user_service.get_contacts(user.uid)
    contacts_phone = [UserWithPhoneResponse(id=u.id, phone=u.phone, name=u.name, image_url=u.image_url) for u in cts]
    return ListUsersWithPhoneResponse(users=contacts_phone)


@router.delete("/contacts/{contact_id}",
               description="Deletes a contact from your friend list and removes yourself from their list")
async def delete_contact(contact_id: str, user: FirebaseAuthenticatedUser = Depends(get_user())):
    pass


@router.get("/friend-requests", description="Returns pending sent and received friendship requests",
            response_model=PendingFriendsRequestsResponse)
async def get_friend_requests(user: FirebaseAuthenticatedUser = Depends(get_user())):
    pass


@router.post("/friend-requests", description="Responds to a friend request, by accepting or denying it")
async def handle_friend_request(r: HandleFriendRequestRequest, user: FirebaseAuthenticatedUser = Depends(get_user())):
    pass


@router.delete("/friend-requests/sent/{contact_id}", description="Cancel a sent friendship request")
async def cancel_friend_request(contact_id: str, user: FirebaseAuthenticatedUser = Depends(get_user())):
    pass
