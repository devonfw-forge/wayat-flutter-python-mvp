import logging
import mimetypes
from typing import Optional

from fastapi import APIRouter, Depends, UploadFile

from app.business.wayat_management.exceptions.http import InvalidImageFormatException
from app.business.wayat_management.models.group import CreateGroupRequest, UpdateGroupRequest, ListGroupsResponse, \
    CreateGroupResponse
from app.business.wayat_management.services.user import UserService
from app.common import get_user
from app.common.infra.gcp.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/groups")

logger = logging.getLogger(__name__)


@router.get("", description="Get the list of groups of a user. "
                             "An optional 'group_id' query parameter allows retrieving the selected group",
            response_model=ListGroupsResponse)
async def list_groups(group_id: Optional[str] = None, user: FirebaseAuthenticatedUser = Depends(get_user()),
                      users: UserService = Depends(UserService)):
    groups = []
    if group_id is None:
        groups += await users.get_user_groups(user.uid)
    else:
        groups = [await users.get_user_group(user.uid, group_id)]
    return ListGroupsResponse(
        groups=groups
    )


@router.post("", description="Create a group", response_model=CreateGroupResponse)
async def create_group(request: CreateGroupRequest, user: FirebaseAuthenticatedUser = Depends(get_user()),
                       users: UserService = Depends(UserService)):
    group_id = await users.create_group(user.uid, request.name, request.members)
    return CreateGroupResponse(id=group_id)


@router.put("/{group_id}", description="Update the information of a group")
async def update_group(group_id: str, request: UpdateGroupRequest,
                       user_service: UserService = Depends(UserService),
                       user: FirebaseAuthenticatedUser = Depends(get_user())):
    await user_service.update_group(user.uid, group_id, request.name, request.members)


@router.delete("/{group_id}", description="Delete a group")
async def delete_group(group_id: str, user: FirebaseAuthenticatedUser = Depends(get_user()),
                       user_service: UserService = Depends(UserService)):
    await user_service.delete_group(uid=user.uid, group_id=group_id)


@router.post("/picture/{group_id}", description="Update the profile picture of a group")
async def upload_group_picture(group_id: str, upload_file: UploadFile, users: UserService = Depends(UserService),
                               user: FirebaseAuthenticatedUser = Depends(get_user())):
    extension = mimetypes.guess_extension(upload_file.content_type)
    if not extension or extension.lower() not in ('.png', '.jpeg', '.jpg'):
        raise InvalidImageFormatException
    await users.update_group_picture(user=user.uid, group=group_id, picture=upload_file.file, extension=extension)
