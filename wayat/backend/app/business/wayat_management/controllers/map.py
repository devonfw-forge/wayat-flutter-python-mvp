import logging

from fastapi import APIRouter

from app.business.wayat_management.models.map import LocationUpdateRequest, UpdateMapRequest

router = APIRouter(prefix="/map")

logger = logging.getLogger(__name__)


@router.post("/update-location", description="Update the location of a user")
async def update_location(request: LocationUpdateRequest):
    # TODO
    pass


@router.post("/update-map", description="Communicates a new status for the map")
async def open_map(request: UpdateMapRequest):
    # TODO
    pass
