from fastapi import Depends

from app.business.wayat_management.models.user import UserDTO
from app.common.infra.firebase import FirebaseAuthenticatedUser
from app.domain.wayat_management.models.user import UserEntity
from app.domain.wayat_management.repositories.user import UserRepository


def map_to_dto(entity: UserEntity) -> UserDTO:
    return None if entity is None else UserDTO(
        id=entity.document_id,
        name=entity.name,
        email=entity.email,
        phone=entity.phone,
        image_url=entity.image_url,
        do_not_disturb=entity.do_not_disturb,
        onboarding_completed=entity.onboarding_completed,
    )


class UserService:
    def __init__(self, user_repository: UserRepository = Depends()):
        self._user_repository = user_repository

    async def get_or_create(self, uid: str, default_data: FirebaseAuthenticatedUser) -> tuple[UserDTO, bool]:
        user_entity = await self._user_repository.get(uid)
        new_user = False
        if user_entity is None:
            new_user = True
            user_entity = await self._user_repository.create(
                uid=uid,
                name=default_data.name,
                email=default_data.email,
                phone=default_data.phone,
                image_url=default_data.picture
            )
        return map_to_dto(user_entity), new_user

    async def find_by_phone(self, phones: list[str]):
        user_entities = await self._user_repository.find_by_phone(phones=phones)
        return list(map(map_to_dto, user_entities))

