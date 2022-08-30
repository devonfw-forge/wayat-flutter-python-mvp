import logging
from typing import Optional

from fastapi import APIRouter, Depends, UploadFile

from app.business.wayat_management.models.group import CreateGroupRequest, UpdateGroupRequest, ListGroupsResponse, \
    CreateGroupResponse
from app.common import get_user
from app.common.infra.gcp.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/groups")

logger = logging.getLogger(__name__)


@router.get("", description="Get the list of groups of a user. "
                             "An optional 'group_id' query parameter allows retrieving the selected group",
            response_model=ListGroupsResponse)
async def list_groups(group_id: Optional[str] = None, user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError


@router.post("", description="Create a group", response_model=CreateGroupResponse)
async def create_group(request: CreateGroupRequest, user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError


@router.put("/{group_id}", description="Update the information of a group")
async def update_group(group_id: str, request: UpdateGroupRequest,
                       user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError


@router.delete("/{group_id}", description="Delete a group")
async def delete_group(group_id: str, user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError


@router.post("/picture/{group_id}", description="Update the profile picture of a group")
async def upload_group_picture(group_id: str, upload_file: UploadFile,
                               user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError
