from fastapi import APIRouter
from app.business.wayat_management.controllers.user import router as user_router
from app.business.wayat_management.controllers.map import router as map_router
from app.business.wayat_management.controllers.contact import router as contact_router
from app.business.wayat_management.controllers.group import router as group_router

# Include all routers here
wayat_router = APIRouter()
wayat_router.include_router(user_router, tags=["User"])
wayat_router.include_router(contact_router, tags=["Contact"])
wayat_router.include_router(group_router, tags=["Group"])
wayat_router.include_router(map_router, tags=["Map"])
