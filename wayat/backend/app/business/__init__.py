from fastapi import APIRouter
from app.business.wayat_management.controllers.user import router as user_router

# Include all routers here

all_router = APIRouter()
all_router.include_router(user_router)
