from pydantic import BaseModel


class IncrementCounterRequest(BaseModel):
    increment: int = 1
