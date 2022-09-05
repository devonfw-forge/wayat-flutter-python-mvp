from pydantic import BaseModel


class Coordinates(BaseModel):
    longitude: float
    latitude: float


class LocationUpdateRequest(BaseModel):
    position: Coordinates
    address: str


class UpdateMapRequest(BaseModel):
    open: bool
