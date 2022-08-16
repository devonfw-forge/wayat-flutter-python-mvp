from app.common.base.base_firebase_repository import BaseFirebaseModel


class CounterEntity(BaseFirebaseModel):
    value: int
