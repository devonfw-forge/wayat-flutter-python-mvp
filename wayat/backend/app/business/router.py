from fastapi import APIRouter

from app.business.counter_management.controllers import spike_router
from app.business.wayat_management.router import wayat_router

all_router = APIRouter()
all_router.include_router(wayat_router)
all_router.include_router(spike_router)
