import logging

from fastapi import APIRouter, Depends

from app.common import get_user
from app.common.infra.gcp.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/groups")

logger = logging.getLogger(__name__)


@router.get("/", description="Get the list of groups of a user")
async def list_groups(user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError


@router.post("/", description="Create a group")
async def create_group(user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError


@router.put("/{group_id}", description="Update the information of a group")
async def update_group(group_id: str, user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError


@router.delete("/{group_id}", description="Delete a group")
async def delete_group(group_id: str, user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError


@router.post("/{group_id}/picture", description="Update the profile picture of a group")
async def upload_group_picture(user: FirebaseAuthenticatedUser = Depends(get_user())):
    # TODO: Implement this method
    raise NotImplementedError
