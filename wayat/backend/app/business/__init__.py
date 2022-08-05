from fastapi import APIRouter

from app.business.wayat_management.controllers import wayat_router
from app.business.counter_management.controllers import spike_router

all_router = APIRouter()
all_router.include_router(wayat_router)
all_router.include_router(spike_router)
