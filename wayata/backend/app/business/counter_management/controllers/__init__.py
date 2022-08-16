from fastapi import APIRouter
from app.business.counter_management.controllers.counter import router as counter_router

# Include all routers here

spike_router = APIRouter()
spike_router.include_router(counter_router, tags=["Counter"])
