import logging

from fastapi import APIRouter, Depends

from app.business.wayat_management.models.user import AddContactsRequest, ListUsersWithPhoneResponse, \
    UserWithPhoneResponse, PendingFriendsRequestsResponse, HandleFriendRequestRequest, dto_to_user_with_phone_response
from app.business.wayat_management.services.map import MapService
from app.business.wayat_management.services.user import UserService
from app.common import get_user
from app.common.infra.gcp.firebase import FirebaseAuthenticatedUser

router = APIRouter(prefix="/contacts")

logger = logging.getLogger(__name__)


@router.post("/add", description="Sends friend requests to the specified users")
async def add_contact(request: AddContactsRequest, user_service: UserService = Depends(UserService),
                      user: FirebaseAuthenticatedUser = Depends(get_user())):
    logger.debug(f"Adding contacts {request.users}")
    await user_service.add_contacts(uid=user.uid, users=request.users)


@router.get("/", description="Get the list of contacts for a user", response_model=ListUsersWithPhoneResponse)
async def get_contacts(user: FirebaseAuthenticatedUser = Depends(get_user()),
                       user_service: UserService = Depends(UserService)):
    logger.debug(f"Getting contacts for user {user.uid}")
    cts = await user_service.get_user_contacts(user.uid)
    contacts_phone = [UserWithPhoneResponse(id=u.id, phone=u.phone, name=u.name, image_url=u.image_url) for u in cts]
    return ListUsersWithPhoneResponse(users=contacts_phone)


@router.delete("/{contact_id}",
               description="Deletes a contact from your friend list and removes yourself from their list")
async def delete_contact(contact_id: str, user: FirebaseAuthenticatedUser = Depends(get_user()),
                         map_service: MapService = Depends(MapService),
                         user_service: UserService = Depends(UserService)):
    await user_service.delete_contact(user_id=user.uid, contact_id=contact_id)
    await map_service.force_status_update(uid=user.uid, force_contacts_update=False)


@router.get("/requests", description="Returns pending sent and received friendship requests",
            response_model=PendingFriendsRequestsResponse)
async def get_friend_requests(user: FirebaseAuthenticatedUser = Depends(get_user()),
                              user_service: UserService = Depends(UserService)):
    pending, sent = await user_service.get_pending_friend_requests(user.uid)

    pending = list(map(dto_to_user_with_phone_response, pending))
    sent = list(map(dto_to_user_with_phone_response, sent))

    return PendingFriendsRequestsResponse(
        sent_requests=sent,
        pending_requests=pending
    )


@router.post("/requests", description="Responds to a friend request, by accepting or denying it")
async def handle_friend_request(r: HandleFriendRequestRequest, user: FirebaseAuthenticatedUser = Depends(get_user()),
                                user_service: UserService = Depends(UserService),
                                map_service: MapService = Depends(MapService)):
    await user_service.respond_friend_request(user_uid=user.uid, friend_uid=r.uid, accept=r.accept)
    if r.accept is True:  # If accepted a friend request refresh maps
        await map_service.force_status_update(uid=user.uid)
        await map_service.force_status_update(uid=r.uid)


@router.delete("/requests/sent/{contact_id}", description="Cancel a sent friendship request")
async def cancel_friend_request(contact_id: str, user: FirebaseAuthenticatedUser = Depends(get_user()),
                                user_service: UserService = Depends(UserService)):
    await user_service.cancel_friend_request(user.uid, contact_id)
