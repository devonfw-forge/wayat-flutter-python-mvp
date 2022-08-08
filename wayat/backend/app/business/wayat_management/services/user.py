import asyncio

from fastapi import Depends

from app.business.wayat_management.models.user import UserDTO, IDType
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

    async def update_user(self,
                          uid: str,
                          **kwargs
                          ):
        # Filter only valid keys
        valid_keys = {"name", "phone", "onboarding_completed"} & kwargs.keys()
        update_data = {key: kwargs[key] for key in valid_keys}

        # Update required fields only
        if update_data:
            await self._user_repository.update(document_id=uid, data=update_data)

    async def add_contacts(self, *, uid: str, users: list[str]):
        coroutines = [self._user_repository.get(u) for u in users]
        contacts_entities: list[UserEntity | None] = await asyncio.gather(*coroutines)
        found_contacts: set[str] = {e.document_id for e in contacts_entities if e is not None}

        self_user = await self._user_repository.get(uid)
        existing_contacts: set[str] = set(self_user.contacts)

        new_contacts = found_contacts.difference(existing_contacts)
        if new_contacts:
            await self._user_repository.update(
                document_id=uid,
                data={"contacts": existing_contacts.union(found_contacts)}
            )
            add_self_to_contact_coroutines = [self.add_contact_to_user(uid=u, contact=uid) for u in new_contacts]
            await asyncio.gather(*add_self_to_contact_coroutines)

    async def add_contact_to_user(self, *, uid: str, contact: str):
        user = await self._user_repository.get(uid)
        existing_contacts: set[str] = set(user.contacts)
        new_contacts = existing_contacts.add(contact)
        await self._user_repository.update(
            document_id=uid,
            data={"contacts": new_contacts}
        )

    async def get_contacts(self, uid):
        self_user = await self._user_repository.get(uid)
        coroutines = [self._user_repository.get(u) for u in self_user.contacts]
        contacts_entities: list[UserEntity | None] = await asyncio.gather(*coroutines)
        return list(map(map_to_dto, contacts_entities))
