import asyncio

from fastapi import Depends
from google.cloud import firestore

from app.business.wayat_management.models.user import UserDTO, IDType
from app.common.exceptions.http import NotFoundException
from app.common.infra.firebase import FirebaseAuthenticatedUser
from app.domain.wayat_management.models.user import UserEntity
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository


def map_to_dto(entity: UserEntity) -> UserDTO:
    return None if entity is None else UserDTO(
        id=entity.document_id,
        name=entity.name,
        email=entity.email,
        phone=entity.phone,
        image_url=entity.image_url,
        do_not_disturb=entity.do_not_disturb,
        share_location=entity.share_location,
        onboarding_completed=entity.onboarding_completed,
    )


class UserService:
    def __init__(self, user_repository: UserRepository = Depends(), status_repository: StatusRepository = Depends()):
        self._user_repository = user_repository
        self._status_repository = status_repository

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
            await self._status_repository.initialize(uid)
        return map_to_dto(user_entity), new_user

    async def find_by_phone(self, phones: list[str]):
        user_entities = await self._user_repository.find_by_phone(phones=phones)
        return list(map(map_to_dto, user_entities))

    async def update_user(self,
                          uid: str,
                          **kwargs
                          ):
        # Filter only valid keys
        valid_keys = {"name", "phone", "onboarding_completed", "share_location", "do_not_disturb"} & kwargs.keys()
        update_data = {key: kwargs[key] for key in valid_keys}

        # Update required fields only
        if update_data:
            await self._user_repository.update(document_id=uid, data=update_data)

    async def add_contacts(self, *, uid: str, users: list[str]):
        # Check new users existence
        contacts = await self.get_contacts(users)
        found_contacts: set[str] = {e.id for e in contacts}

        self_user = await self._user_repository.get(uid)
        existing_contacts: set[str] = set(self_user.contacts)

        new_contacts = found_contacts.difference(existing_contacts)
        if new_contacts:
            await self._user_repository.create_friend_request(uid, list(new_contacts))

    async def get_user_contacts(self, uid):
        return list(map(map_to_dto, await self._user_repository.get_contacts(uid)))

    async def get_contact(self, uid: str):
        """
        Returns user DTO
        """
        user = await self._user_repository.get(uid)
        if user is not None:
            user = map_to_dto(user)
        return user

    async def get_contacts(self, uids: list[str]):
        coroutines = [self.get_contact(u) for u in uids]
        contacts_dtos: list[UserDTO | None] = await asyncio.gather(*coroutines)
        return [e for e in contacts_dtos if e is not None]

    async def get_pending_friend_requests(self, uid):
        """
        Returns pending friend requests, received and sent
        """
        user = await self._user_repository.get(uid)
        if user is None:
            raise NotFoundException(detail=f"User {uid} not found")

        return await self.get_contacts(user.pending_requests), await self.get_contacts(user.sent_requests)

    async def cancel_friend_request(self, uid, contact_id):
        """
        Cancels a pending sent friend request
        """
        await self._user_repository.cancel_friend_request(sender_id=uid, receiver_id=contact_id)

    async def respond_friend_request(self, user_uid: str, friend_uid: str, accept: bool):
        """
        Responds a friend request by either accepting or denying it
        """
        await self._user_repository.respond_friend_request(self_uid=user_uid, friend_uid=friend_uid, accept=accept)

    async def delete_contact(self, user_id, contact_id):
        """
        Deletes a contact
        """
        await self._user_repository.delete_contact(user_id, contact_id)
        # TODO: Regenerate contact refs