import logging

from fastapi import APIRouter, Depends

from app.business.wayat_management.models.user import (
    UserProfileResponse,
    UpdateUserRequest,
    ListUsersWithPhoneResponse,
    FindByPhoneRequest,
    AddContactsRequest,
    UpdatePreferencesRequest, UserWithPhoneResponse,
)
from app.business.wayat_management.services.user import UserService
from app.common import get_user
from app.common.infra.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/users")

logger = logging.getLogger(__name__)


@router.get("/profile", description="Get a user profile", response_model=UserProfileResponse)
async def get_user_profile(user: FirebaseAuthenticatedUser = Depends(get_user()),
                           user_service: UserService = Depends()):
    user_dto, new_user = await user_service.get_or_create(user.uid, user)
    return UserProfileResponse(**user_dto.dict(), new_user=new_user)


@router.post("/profile",
             description="Update a user profile, setting those values that were explicitly set, even if set to null")
async def update_user_profile(request: UpdateUserRequest,
                              user: FirebaseAuthenticatedUser = Depends(get_user()),
                              user_service: UserService = Depends()):
    logger.info(f"Updating {user.uid=} with values {request.dict(exclude_unset=True)}")
    await user_service.update_user(user.uid, **request.dict(exclude_unset=True))


@router.post("/find-by-phone",
             description="Get a list of users filtered by phone",
             response_model=ListUsersWithPhoneResponse,
             dependencies=[Depends(get_user())])
async def get_users_filtered(request: FindByPhoneRequest, user_service: UserService = Depends(UserService)):
    users = await user_service.find_by_phone(request.phones)
    users_phone = [UserWithPhoneResponse(id=u.id, phone=u.phone, name=u.name, image_url=u.image_url) for u in users]
    return ListUsersWithPhoneResponse(users=users_phone)


@router.post("/add-contact", description="Add a list of users to the contact list")
async def add_contact(request: AddContactsRequest, user_service: UserService = Depends(UserService),
                      user: FirebaseAuthenticatedUser = Depends(get_user())):
    await user_service.add_contacts(request.users)


@router.post("/preferences", description="Update the preferences of a user")
async def update_preferences(request: UpdatePreferencesRequest):
    # TODO
    pass


@router.get("/contacts", description="Get the list of contacts for a user", response_model=ListUsersWithPhoneResponse)
async def get_contacts():
    # TODO
    pass
