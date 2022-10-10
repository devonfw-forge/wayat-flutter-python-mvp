import asyncio
import logging
from datetime import datetime
from typing import Optional, List, Tuple
from fastapi import Depends
from google.cloud import firestore
from google.cloud.firestore import AsyncClient, AsyncTransaction

from app.common.base.base_entity import new_uuid
from app.common.infra.gcp.base_firebase_repository import BaseFirestoreRepository, get_async_client
from app.domain.wayat_management.utils import get_current_time
from app.domain.wayat_management.models.user import UserEntity, Location, GroupInfo

logger = logging.getLogger(__name__)


class UserRepository(BaseFirestoreRepository[UserEntity]):
    def __init__(self, client: AsyncClient = Depends(get_async_client)):
        super(UserRepository, self).__init__(collection_path="users", model=UserEntity, client=client)

    async def create(self, *,
                     uid: str,
                     name: Optional[str],
                     email: Optional[str],
                     phone: Optional[str],
                     image_ref: Optional[str]
                     ):
        entity = UserEntity(
            document_id=uid,
            name=name,
            email=email,
            phone=phone,
            image_ref=image_ref,
        )
        await self.add(model=entity)
        return entity

    async def find_by_phone(self, *, phones: list[str]):
        return [item async for item in self.where("phone", 'in', phones)]

    async def get_contacts(self, uid: str) -> Tuple[list[UserEntity], list[str]]:
        """
        Returns the list of contacts (UserEntity) and the list of ids of users with which the user is sharing location

        :param uid: the UID of the User
        :return: the list of contacts and the list of ids with which the user is sharing the location
        """
        self_user = await self.get_or_throw(uid)
        coroutines = [self.get_or_throw(u) for u in self_user.contacts]
        contacts_entities: list[UserEntity] = await asyncio.gather(*coroutines)  # type: ignore
        return contacts_entities, self_user.location_shared_with

    async def update_user_location(self, uid: str, latitude: float, longitude: float, address: str) -> None:
        location: Location = Location(
            value=(latitude, longitude),
            last_updated=get_current_time(),
            address=address
        )
        await self.update(data={"location": location.dict()}, document_id=uid)

    async def get_user_groups(self, uid: str) -> Tuple[List[GroupInfo], UserEntity]:
        user = await self.get_or_throw(uid)
        return user.groups, user

    async def get_user_location(self, uid: str, force=False) -> Tuple[Location | None, list[str]]:
        """
        Returns the location of a User. If force=False (default), this Location will be None if the User has the
        share_location property set to False.

        :param force: whether to ignore share_location or not :param uid: the UID of the User
        :return: the Location of the User, or None if it's not available
        and the list of contacts with which the user is sharing
        """
        user_entity = await self.get_or_throw(uid)
        if user_entity.location is None:  # if not available, return None
            return None, user_entity.location_shared_with
        elif not force and not user_entity.share_location:  # if not forcing, decide on not(share_location)
            return None, user_entity.location_shared_with
        else:
            return user_entity.location, user_entity.location_shared_with

    async def find_contacts_with_map_open(self, uid: str, in_shared_list: bool = True) -> list[UserEntity]:
        result_stream = (
            self._get_collection_reference()
            .where("contacts", "array_contains", uid)
            .where("map_open", "==", True)
            .where("map_valid_until", ">", get_current_time())
            .stream()
        )
        all_models = [self._model(document_id=result.id, **result.to_dict())
                      async for result in result_stream]  # type: ignore
        if in_shared_list is True:
            user = await self.get_or_throw(document_id=uid)
            shared_list = user.location_shared_with
            models = [el for el in all_models if el.document_id in shared_list]
        else:
            models = all_models
        return models

    async def update_last_status(self, uid: str):
        await self.update(document_id=uid, data={"last_status_update": get_current_time()})

    async def create_friend_request(self, sender: str, receivers: list[str]):
        transaction = self._client.transaction()
        sender_ref = self._get_document_reference(sender)
        receivers_ref = [self._get_document_reference(u) for u in receivers]

        @firestore.async_transactional
        async def execute(t: AsyncTransaction):
            update_sender = {
                "sent_requests": firestore.ArrayUnion(receivers)
            }
            self._validate_update(update_sender)
            update_receivers = {
                "pending_requests": firestore.ArrayUnion([sender])
            }
            self._validate_update(update_receivers)
            t.update(sender_ref, update_sender)
            for r in receivers_ref:
                t.update(r, update_receivers)

        await execute(transaction)

    async def cancel_friend_request(self, *, sender_id: str, receiver_id: str):
        transaction = self._client.transaction()
        sender_ref = self._get_document_reference(sender_id)
        receiver_ref = self._get_document_reference(receiver_id)

        @firestore.async_transactional
        async def execute(t: AsyncTransaction):
            update_sender = {
                "sent_requests": firestore.ArrayRemove([receiver_id])
            }
            self._validate_update(update_sender)
            update_receiver = {
                "pending_requests": firestore.ArrayRemove([sender_id])
            }
            self._validate_update(update_receiver)
            t.update(sender_ref, update_sender)
            t.update(receiver_ref, update_receiver)

        await execute(transaction)

    async def update_map_info(self, uid: str, map_open: bool, map_valid_until: datetime | None = None):
        data = {"map_open": map_open}
        if map_valid_until is not None:
            data["map_valid_until"] = map_valid_until  # type: ignore
        await self.update(document_id=uid, data=data)

    async def respond_friend_request(self, *, self_uid: str, friend_uid: str, accept: bool):
        if not accept:
            await self.cancel_friend_request(sender_id=friend_uid, receiver_id=self_uid)
        else:
            transaction = self._client.transaction()
            sender_ref = self._get_document_reference(friend_uid)
            receiver_ref = self._get_document_reference(self_uid)

            @firestore.async_transactional
            async def execute(t: AsyncTransaction):
                sender = await self.get_or_throw(friend_uid, transaction=t)
                if self_uid in sender.sent_requests:
                    update_sender = {
                        "sent_requests": firestore.ArrayRemove([self_uid]),
                        "contacts": firestore.ArrayUnion([self_uid]),
                        "location_shared_with": firestore.ArrayUnion([self_uid]),
                    }
                    self._validate_update(update_sender)
                    update_receiver = {
                        "pending_requests": firestore.ArrayRemove([friend_uid]),
                        "contacts": firestore.ArrayUnion([friend_uid]),
                        "location_shared_with": firestore.ArrayUnion([friend_uid]),
                    }
                    self._validate_update(update_receiver)
                    t.update(sender_ref, update_sender)
                    t.update(receiver_ref, update_receiver)
                else:
                    logger.error("Trying to accept a friend request not received")
            await execute(transaction)

    async def delete_contact(self, a_id, b_id):
        transaction = self._client.transaction()
        a_ref = self._get_document_reference(a_id)
        b_ref = self._get_document_reference(b_id)

        @firestore.async_transactional
        async def execute(t: AsyncTransaction):
            update_a = {
                "contacts": firestore.ArrayRemove([b_id]),
                "location_shared_with": firestore.ArrayRemove([b_id]),
            }
            self._validate_update(update_a)
            update_b = {
                "contacts": firestore.ArrayRemove([a_id]),
                "location_shared_with": firestore.ArrayRemove([a_id]),
            }
            self._validate_update(update_b)
            t.update(a_ref, update_a)
            t.update(b_ref, update_b)

        await execute(transaction)

    async def create_group(self, user_id: str, group_name: str, members: list[str], image: str) -> GroupInfo:
        new_group = GroupInfo(
            id=new_uuid().hex,
            name=group_name,
            contacts=members,
            image_ref=image
        )
        update = {
            "groups": firestore.ArrayUnion([new_group.dict()])
        }
        await self.update(document_id=user_id, data=update)
        return new_group

    async def update_user_groups(self, user_id: str, user_groups: list[GroupInfo]):
        update = {
            "groups": [g.dict() for g in user_groups]
        }
        await self.update(document_id=user_id, data=update)

    async def update_sharing_preferences(self, user_id: str, contact_id: str, share_location: bool):
        if share_location is True:
            update = {
                "location_shared_with": firestore.ArrayUnion([contact_id]),
            }
        else:
            update = {
                "location_shared_with": firestore.ArrayRemove([contact_id]),
            }
        await self.update(document_id=user_id, data=update)

    async def add_notifications_token(self, *, user_id: str, token: str):
        update = {
            "notifications_tokens": firestore.ArrayUnion([token]),
        }
        await self.update(document_id=user_id, data=update)


