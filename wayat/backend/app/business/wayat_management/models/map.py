from typing import Optional

from pydantic import BaseModel


class Coordinates(BaseModel):
    longitude: float
    latitude: float


class LocationUpdateRequest(BaseModel):
    position: Coordinates
    timestamp: int


class UpdateMapRequest(BaseModel):
    open: bool
    position: Optional[Coordinates]
