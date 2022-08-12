from typing import Optional

from pydantic import BaseModel


class Coordinates(BaseModel):
    longitude: float
    latitude: float


class LocationUpdateRequest(BaseModel):
    position: Coordinates


class UpdateMapRequest(BaseModel):
    open: bool
