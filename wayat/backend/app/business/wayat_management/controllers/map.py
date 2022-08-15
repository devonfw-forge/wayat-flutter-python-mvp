import logging

from fastapi import APIRouter, Depends

from app.business.wayat_management.models.map import LocationUpdateRequest, UpdateMapRequest
from app.business.wayat_management.services.map import MapService
from app.common import get_user
from app.common.infra.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/map")

logger = logging.getLogger(__name__)


@router.post("/update-location", description="Update the location of a user")
async def update_location(request: LocationUpdateRequest,
                          user: FirebaseAuthenticatedUser = Depends(get_user()),
                          map_service: MapService = Depends()):
    logger.debug(f"Updating location {request.position}")
    await map_service.update_location(
        user.uid,
        latitude=request.position.latitude,
        longitude=request.position.longitude
    )


@router.post("/update-map", description="Communicates a new status for the map")
async def open_map(
        request: UpdateMapRequest,
        user: FirebaseAuthenticatedUser = Depends(get_user()),
        map_service: MapService = Depends()
):
    logger.debug(f"Map status update: user={user.uid}, open={request.open}")
    await map_service.update_map_status(user.uid, request.open)
