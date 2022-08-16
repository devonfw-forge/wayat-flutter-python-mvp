import logging

from fastapi import APIRouter, Depends

from app.business.counter_management.models.counter import IncrementCounterRequest
from app.business.counter_management.services.counter import CounterService

router = APIRouter(prefix="/counter")

logger = logging.getLogger(__name__)


@router.post("/increment", description="Increments the value of the counter by the amount given")
async def increment_counter(request: IncrementCounterRequest, counter_service: CounterService = Depends()):
    await counter_service.increment(request.increment)
