from fastapi import Depends
from app.domain.counter_management.repositories.counter import CounterRepository


class CounterService:
    def __init__(self, repository: CounterRepository = Depends()):
        self.repository = repository

    async def increment(self, value: int):
        await self.repository.increment(value)
