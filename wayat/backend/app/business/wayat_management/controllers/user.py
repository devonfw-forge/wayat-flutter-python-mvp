import logging
import mimetypes

from fastapi import APIRouter, Depends, UploadFile

from app.business.wayat_management.exceptions.http import InvalidImageFormatException, PhoneInUseException
from app.business.wayat_management.models.user import (
    UserProfileResponse,
    UpdateUserRequest,
    ListUsersWithPhoneAndSharingIndicatorResponse,
    FindByPhoneRequest,
    UpdatePreferencesRequest,
    dto_to_user_with_phone_response,
)
from app.business.wayat_management.services.map import MapService
from app.business.wayat_management.services.user import UserService
from app.common import get_user
from app.common.exceptions.http import HTTPError
from app.common.infra.gcp.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/users")

logger = logging.getLogger(__name__)


@router.get("/profile", description="Get a user profile", response_model=UserProfileResponse)
async def get_user_profile(user: FirebaseAuthenticatedUser = Depends(get_user()),
                           user_service: UserService = Depends()):
    logger.debug(f"Getting user profile with id {user.uid}")
    user_dto, new_user = await user_service.get_or_create(user.uid, user)
    return UserProfileResponse(**user_dto.dict(), new_user=new_user)


@router.delete("/profile", description="Delete the account of a user")
async def delete_account(user: FirebaseAuthenticatedUser = Depends(get_user()),
                         user_service: UserService = Depends(),
                         maps_service: MapService = Depends()):
    logger.info(f"Deleting the account of the user with uid={user.uid}")
    await user_service.delete_account(user.uid)
    await maps_service.regenerate_maps_containing_user(user.uid)


@router.post("/profile",
             description="Update a user profile, setting those values that were explicitly set, even if set to null",
             responses={
                 409: {"model": HTTPError, "description": "If the phone is already in use"}
             }
             )
async def update_user_profile(request: UpdateUserRequest,
                              user: FirebaseAuthenticatedUser = Depends(get_user()),
                              user_service: UserService = Depends()):
    logger.info(f"Updating user={user.uid} with values {request.dict(exclude_unset=True)}")
    if request.phone and await user_service.phone_in_use(request.phone):
        raise PhoneInUseException

    await user_service.update_user(user.uid, **request.dict(exclude_unset=True))


@router.post("/profile/picture", description="Updates the user profile picture")
async def update_profile_picture(upload_file: UploadFile,
                                 user: FirebaseAuthenticatedUser = Depends(get_user()),
                                 user_service: UserService = Depends()):
    extension = mimetypes.guess_extension(upload_file.content_type)
    if not extension or extension.lower() not in ('.png', '.jpeg', '.jpg'):
        raise InvalidImageFormatException
    await user_service.update_profile_picture(
        user.uid,
        extension,
        upload_file.file
    )


@router.post("/find-by-phone",
             description="Get a list of users filtered by phone",
             response_model=ListUsersWithPhoneAndSharingIndicatorResponse,
             dependencies=[Depends(get_user())])
async def get_users_filtered(request: FindByPhoneRequest, user_service: UserService = Depends(UserService)):
    logger.debug(f"Getting contacts with phones {request.phones}")
    users = await user_service.find_by_phone(request.phones)
    users_phone = list(map(dto_to_user_with_phone_response, users))
    return ListUsersWithPhoneAndSharingIndicatorResponse(users=users_phone)


@router.post("/preferences", description="Update the preferences of a user")
async def update_preferences(request: UpdatePreferencesRequest,
                             user_service: UserService = Depends(UserService),
                             map_service: MapService = Depends(MapService),
                             user: FirebaseAuthenticatedUser = Depends(get_user())):
    logger.info(f"Updating preferences for user {user.uid} with values {request.dict(exclude_unset=True)}")
    await user_service.update_user(user.uid, **request.dict(exclude_unset=True))
    if request.share_location is False:
        # share_location was changed to false in this request, so we must refresh the user status
        # on all the maps in which he's present
        logger.debug(f"Updating maps containing user {user.uid}")
        await map_service.regenerate_maps_containing_user(user.uid)
    elif request.share_location is True:
        # share_location was changed to true in this request, so we must refresh the user status
        # on all the maps of the user friend which "should be updated"
        logger.debug(f"Updating maps of {user.uid} friends")
        await map_service.update_contacts_status(uid=user.uid, force=True)
