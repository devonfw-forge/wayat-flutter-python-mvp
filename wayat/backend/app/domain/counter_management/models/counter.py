from app.common.infra.gcp.base_firebase_repository import BaseFirebaseModel


class CounterEntity(BaseFirebaseModel):
    value: int
