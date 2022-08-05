import logging

from fastapi import APIRouter, Depends

from app.business.wayat_management.models.user import (
    UserProfileResponse,
    UpdateUserRequest,
    ListUsersWithPhoneResponse,
    FindByPhoneRequest,
    AddContactsRequest,
    UpdatePreferencesRequest,
)
from app.business.wayat_management.services.user import UserService
from app.common import get_user, User
from app.common.infra.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/users")

logger = logging.getLogger(__name__)


@router.get("/profile", description="Get a user profile", response_model=UserProfileResponse)
async def get_user_profile(user: FirebaseAuthenticatedUser = Depends(get_user()),
                           user_service: UserService = Depends()):
    user_dto, new_user = await user_service.get_or_create(user.uid, user)
    return UserProfileResponse(**user_dto.dict(), new_user=new_user)


@router.post("/profile", description="Update a user profile")
async def update_user_profile(request: UpdateUserRequest):
    logger.info(f"Updating user with values{request=}")


@router.post("/find-by-phone",
             description="Get a list of users filtered by phone",
             response_model=ListUsersWithPhoneResponse)
async def get_users_filtered(request: FindByPhoneRequest):
    # TODO
    pass


@router.post("/add-contact", description="Add a list of users to the contact list")
async def add_contact(request: AddContactsRequest):
    # TODO
    pass


@router.post("/preferences", description="Update the preferences of a user")
async def update_preferences(request: UpdatePreferencesRequest):
    # TODO
    pass


@router.get("/contacts", description="Get the list of contacts for a user", response_model=ListUsersWithPhoneResponse)
async def get_contacts():
    # TODO
    pass
