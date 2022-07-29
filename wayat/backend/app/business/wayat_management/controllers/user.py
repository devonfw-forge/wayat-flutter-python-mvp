import logging

from fastapi import APIRouter, Depends

from app.business.wayat_management.models.user import UserProfileResponse
from app.common import get_user

router = APIRouter(prefix="/users")

logger = logging.getLogger(__name__)


@router.get("/profile", description="Gets a user profile", response_model=UserProfileResponse)
async def get_user_profile():
    logger.info("Retrieving user profile information")

