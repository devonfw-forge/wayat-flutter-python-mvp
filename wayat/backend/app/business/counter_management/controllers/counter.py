import logging

from fastapi import APIRouter

from app.business.counter_management.models.counter import IncrementCounterRequest

router = APIRouter(prefix="/counter")

logger = logging.getLogger(__name__)


@router.post("/increment", description="Increments the value of the counter by the amount given")
async def increment_counter(request: IncrementCounterRequest):
    # TODO
    pass