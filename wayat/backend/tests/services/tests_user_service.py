import io
import unittest
from typing import BinaryIO
from unittest import IsolatedAsyncioTestCase
from unittest.mock import MagicMock, patch, call

from firebase_admin.messaging import SendResponse  # type: ignore
from requests import RequestException

from app.business.wayat_management.services.user import UserService
from app.common.exceptions.http import NotFoundException
from app.common.exceptions.runtime import ResourceNotFoundException
from app.common.infra.gcp.cloud_messaging import CloudMessaging
from app.common.infra.gcp.firebase import FirebaseAuthenticatedUser
from app.domain.wayat_management.models.user import UserEntity, GroupInfo
from app.domain.wayat_management.repositories.files import FileStorage, StorageSettings
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository

TEST_IMAGE_BYTES = b'test_data'
TEST_RESIZED_BYTES = b'resized_data'


async def extract_picture_mock(*args, **kwargs):
    return "created_url"


def resize_image_mock(data: BinaryIO | bytes, size) -> bytes:
    return TEST_RESIZED_BYTES


async def mock_find_by_phone(phones: list[str]):
    data = {
        "+34-TEST": UserEntity(
            document_id="test",
            email="test@test.com",
            image_url="test",
            name="test",
            phone="+34-TEST",
        )
    }
    return [data[key] for key in phones if key in data]


@patch("app.business.wayat_management.services.user.resize_image", new=resize_image_mock)
class UserServiceTests(IsolatedAsyncioTestCase):

    async def asyncSetUp(self):
        # Mocks
        self.mock_user_repo = MagicMock(UserRepository)
        self.mock_status_repo = MagicMock(StatusRepository)
        self.mock_file_repository = MagicMock(FileStorage)
        self.mock_file_cloud_messaging = MagicMock(CloudMessaging)
        self.mock_file_repository.generate_signed_url.return_value = "created_url"
        self.storage_settings = MagicMock(StorageSettings)
        self.storage_settings.default_picture = "images/test_default"
        self.storage_settings.thumbnail_size = 200

        # UserService
        self.user_service = UserService(
            self.mock_user_repo,
            self.mock_status_repo,
            self.mock_file_repository,
            self.mock_file_cloud_messaging,
            self.storage_settings
        )

        self._backup_extract_picture = self.user_service._extract_picture
        self.user_service._extract_picture = extract_picture_mock

    async def test_get_user_that_not_exists_should_create_it(self):
        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], name="test",
                                              picture="test_picture")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_ref=test_data.picture
        )

        self.mock_user_repo.get.return_value = None
        self.mock_user_repo.create.return_value = test_entity

        # Call to be tested
        result_dto, is_new_user = await self.user_service.get_or_create(test_data.uid, test_data)

        # Asserts
        self.mock_user_repo.create.assert_called_with(
            uid=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_ref="created_url",
        )
        self.mock_status_repo.initialize.assert_called_with(test_data.uid)

        assert is_new_user
        assert result_dto == self.user_service.map_to_dto(test_entity)

    async def test_get_user_that_exists_should_return_it(self):
        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_prefix = "+TEST"
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            phone_prefix=test_prefix,
            image_url=test_data.picture
        )

        self.mock_user_repo.get.return_value = test_entity

        # Call to be tested
        result_dto, is_new_user = await self.user_service.get_or_create(test_data.uid, test_data)

        # Asserts
        self.mock_user_repo.get.assert_called_with(test_data.uid)
        self.mock_user_repo.create.assert_not_called()
        self.mock_status_repo.initialize.assert_not_called()

        assert not is_new_user
        assert result_dto == self.user_service.map_to_dto(test_entity)
        assert result_dto.phone_prefix == test_prefix

    async def test_update_user_should_only_accept_valid_params(self):
        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")

        test_update_valid = {
            "name": test_data.name,
            "phone": test_data.phone,
            "phone_prefix": "+34"
        }

        test_update_with_invalid_keys = {
            "name": test_data.name,
            "phone": test_data.phone,
            "phone_prefix": "+34",
            "invalid": "test"
        }

        # Call to be tested
        await self.user_service.update_user(test_data.uid, **test_update_with_invalid_keys)

        # Asserts
        self.mock_user_repo.update.assert_called_with(document_id=test_data.uid, data=test_update_valid)

    async def test_add_contacts_should_add_only_valid_ones(self):
        def mocking_get_user(uid: str):
            if uid == "test" or uid == "test-friend":
                return test_entity
            else:
                raise ResourceNotFoundException

        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_url=test_data.picture
        )

        self.mock_user_repo.get_or_throw.side_effect = mocking_get_user

        # Call to be tested
        ex = False
        try:
            await self.user_service.add_contacts(uid=test_data.uid, users=["test-friend"])
        except ResourceNotFoundException:
            ex = True

        self.mock_user_repo.create_friend_request.assert_called_with(test_data.uid, [test_entity.document_id])
        assert ex == False

        ex = False
        try:
            await self.user_service.add_contacts(uid=test_data.uid, users=["invalid"])
        except ResourceNotFoundException:
            ex = True

        # Asserts
        assert ex == True

    async def test_add_contacts_should_add_new_ones_and_accept_pending(self):
        def mocking_get_user(uid: str):
            if uid == "test":
                return test_entity
            if uid == "test-friend-1":
                return test_entity_1
            if uid == "test-friend-2":
                return test_entity_2
            else:
                raise ResourceNotFoundException

        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_url=test_data.picture,
            pending_requests=["test-friend-1"]
        )

        test_friend_1 = FirebaseAuthenticatedUser(uid="test-friend-1", email="test@email.es", roles=[], picture="test",
                                                  name="test")
        test_entity_1 = UserEntity(
            document_id=test_friend_1.uid,
            name=test_friend_1.name,
            email=test_friend_1.email,
            phone=test_friend_1.phone,
            image_url=test_friend_1.picture
        )

        test_friend_2 = FirebaseAuthenticatedUser(uid="test-friend-2", email="test@email.es", roles=[], picture="test",
                                                  name="test")
        test_entity_2 = UserEntity(
            document_id=test_friend_2.uid,
            name=test_friend_2.name,
            email=test_friend_2.email,
            phone=test_friend_2.phone,
            image_url=test_friend_2.picture
        )
        self.user_service.respond_friend_request = MagicMock(self.user_service.respond_friend_request)
        self.mock_user_repo.get_or_throw.side_effect = mocking_get_user
        await self.user_service.add_contacts(uid=test_data.uid, users=["test-friend-1", "test-friend-2"])
        self.mock_user_repo.create_friend_request.assert_called_with(test_data.uid, [test_entity_2.document_id])
        self.user_service.respond_friend_request.assert_called_with(test_data.uid, test_friend_1.uid, True)

    async def test_get_pending_friend_requests_should_return_ok(self):
        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_pending_data = FirebaseAuthenticatedUser(uid="test-pending", email="test@email.es", roles=[],
                                                      picture="test", name="test-pending")
        test_sent_data = FirebaseAuthenticatedUser(uid="test-sent", email="test@email.es", roles=[],
                                                   picture="test", name="test-sent")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_url=test_data.picture,
            sent_requests=[test_sent_data.uid],
            pending_requests=[test_pending_data.uid]
        )

        test_entity_pending = UserEntity(
            document_id=test_pending_data.uid,
            name=test_pending_data.name,
            email=test_pending_data.email,
            phone=test_pending_data.phone,
            image_url=test_pending_data.picture,
        )

        test_entity_sent = UserEntity(
            document_id=test_sent_data.uid,
            name=test_sent_data.name,
            email=test_sent_data.email,
            phone=test_sent_data.phone,
            image_url=test_sent_data.picture,
        )

        def mocking_get_user(uid: str):
            if uid == test_entity.document_id:
                return test_entity
            if uid == test_entity_pending.document_id:
                return test_entity_pending
            if uid == test_entity_sent.document_id:
                return test_entity_sent
            else:
                raise ResourceNotFoundException

        self.mock_user_repo.get_or_throw.side_effect = mocking_get_user

        # Call to be tested
        pending, sent = await self.user_service.get_pending_friend_requests(test_data.uid)

        # Asserts
        assert pending == [self.user_service.map_to_dto(test_entity_pending)]
        assert sent == [self.user_service.map_to_dto(test_entity_sent)]

        # Test exception
        found_exception = False
        try:
            await self.user_service.get_pending_friend_requests('bad')
        except ResourceNotFoundException:
            found_exception = True

        assert found_exception == True

    async def test_find_by_phone_should_return_filtered_users_data(self):
        test_entity = UserEntity(
            document_id="test",
            email="test@test.com",
            image_url="test",
            name="test",
            phone="+34-TEST",
        )
        self.mock_user_repo.find_by_phone.return_value = [test_entity]

        # Call to be tested
        user_dtos = await self.user_service.find_by_phone([test_entity.phone])

        # Asserts
        self.assertCountEqual(user_dtos, [self.user_service.map_to_dto(test_entity)])
        self.mock_user_repo.find_by_phone.assert_called_with(phones=[test_entity.phone])

    async def test_get_contacts_should_return_user_data(self):
        test_entity = UserEntity(
            document_id="test",
            email="test@test.com",
            image_url="test",
            name="test",
            phone="+34-TEST",
        )
        self.mock_user_repo.get_contacts.return_value = ([test_entity], test_entity)

        # Call to be tested
        user_dtos, _ = await self.user_service.get_user_contacts("uid")

        # Asserts
        self.assertCountEqual(user_dtos, [self.user_service.map_to_dto(test_entity)])
        self.mock_user_repo.get_contacts.assert_called_with("uid")

    async def test_cancel_sent_request_should_call_repo(self):
        test_user, test_friend = "user", "friend"
        # Call to be tested
        await self.user_service.cancel_friend_request(uid=test_user, contact_id=test_friend)

        # Asserts
        self.mock_user_repo.cancel_friend_request.assert_called_with(sender_id=test_user, receiver_id=test_friend)

    async def test_handle_friend_request_should_call_repo(self):
        test_user, test_friend, accept = "user", "friend", True
        # Call to be tested
        await self.user_service.respond_friend_request(self_user_uid=test_user, friend_uid=test_friend, accept=accept)

        # Asserts
        self.mock_user_repo.respond_friend_request.assert_called_with(
            self_uid=test_user, friend_uid=test_friend, accept=accept
        )

    async def test_set_push_token_request_should_call_repo(self):
        # Call to be tested
        await self.user_service.set_notifications_token("test", "token")

        # Asserts
        self.mock_user_repo.add_notifications_token.assert_called_with(user_id="test", token="token")

    async def test_delete_friend_should_update_groups(self):
        test_friend = "friend"
        user, group_name, members, picture = "testuser", "groupname", [test_friend, "other_friend"], \
                                             self.storage_settings.default_picture
        user_group_info = GroupInfo(
            id="test",
            name=group_name,
            image_ref=picture,
            contacts=members
        )
        contact_group_info = GroupInfo(
            id="test-contact",
            name=group_name,
            image_ref=picture,
            contacts=[user, "other_friend"]
        )
        extra_group = GroupInfo(
            id="extra-group",
            name="extra-group",
            image_ref=picture,
            contacts=["other-contacts", "contacts-other"]
        )

        expected_contacts = ["other_friend"]

        def mock_get_user_groups(u: str):
            if u == user:
                return [user_group_info, extra_group], None
            if u == test_friend:
                return [contact_group_info, extra_group], None

        self.mock_user_repo.get_user_groups.side_effect = mock_get_user_groups

        # Call under test and asserts
        await self.user_service.delete_contact(user, test_friend)

        # Asserts

        user_group_info.contacts = expected_contacts
        contact_group_info.contacts = expected_contacts

        self.mock_user_repo.delete_contact.assert_called_with(user, test_friend)
        self.mock_user_repo.update_user_groups.assert_has_calls(
            [
                call(user_id=test_friend, user_groups=[contact_group_info, extra_group]),
                call(user_id=user, user_groups=[user_group_info, extra_group])
            ],
            any_order=True)

    async def test_update_contact_prefs_should_call_repo(self):
        user, contact, share = "test", "test_contact", True
        # Call under test
        await self.user_service.update_contact_prefs(user_id=user, contact_id=contact, share_location=share)

        # Asserts
        self.mock_user_repo.update_sharing_preferences.assert_called_with(user, contact, share)

    async def test_upload_profile_picture_should_call_repo(self):
        # Mocks
        self.mock_file_repository.upload_profile_image.return_value = "test/ref"

        # Call under test
        await self.user_service.update_profile_picture("uid_test", ".jpeg", TEST_IMAGE_BYTES)

        # Asserts
        self.mock_file_repository.upload_profile_image.assert_called_with("uid_test.jpeg", TEST_RESIZED_BYTES)

    @patch("app.business.wayat_management.services.user.requests")
    async def test_extract_picture_when_invalid_url_should_return_default(self, mock_requests):
        # Mocks
        def mocked_get(url):
            class MockResponse:
                pass

            if url == "RAISE":
                raise RequestException
            elif url == "FAIL":
                response = MockResponse()
                response.status_code = 400
                return response
            elif url == "INVALID":
                response = MockResponse()
                response.status_code = 200
                headers = {"Content-Type": "image/invalid"}
                response.headers = headers
                return response

        mock_requests.get = mocked_get

        # Calls under test and asserts
        assert await self._backup_extract_picture(uid="test_uid", url="") == self.storage_settings.default_picture
        assert await self._backup_extract_picture(uid="test_uid", url="RAISE") == self.storage_settings.default_picture
        assert await self._backup_extract_picture(uid="test_uid", url="FAIL") == self.storage_settings.default_picture
        assert await self._backup_extract_picture(uid="test_uid",
                                                  url="INVALID") == self.storage_settings.default_picture

    @patch("app.business.wayat_management.services.user.requests")
    async def test_extract_picture_when_valid_url_should_return_upload(self, mock_requests):
        # Mocks
        class MockResponse:
            status_code = 200
            headers = {"Content-Type": "image/png"}
            content = TEST_IMAGE_BYTES

        mock_requests.get.return_value = MockResponse()

        # Call under test
        await self._backup_extract_picture(uid="test_uid", url="test_url")

        # Asserts
        self.mock_file_repository.upload_profile_image.assert_called_with("test_uid.png", TEST_RESIZED_BYTES)

    async def test_phone_in_use_when_phone_in_use_should_return_true(self):
        # Mocks
        self.mock_user_repo.find_by_phone.side_effect = mock_find_by_phone

        # Call under test and asserts
        assert await self.user_service.phone_in_use("+34-TEST") is True

    async def test_phone_in_use_when_phone_not_in_use_should_return_false(self):
        # Mocks
        self.mock_user_repo.find_by_phone.side_effect = mock_find_by_phone

        # Call under test and asserts
        assert await self.user_service.phone_in_use("+34-NO_TEST") is False

    async def test_delete_account_should_delete_all_contacts_status_and_profile(self):
        test_entity = UserEntity(
            document_id="uid",
            name="name",
            email="email",
            phone="phone",
            image_ref="image"
        )

        test_entity.contacts = ["test"]

        # Mocks
        self.mock_user_repo.get_or_throw.return_value = test_entity

        mock_service = MagicMock(UserService)

        self.user_service.delete_contact = mock_service.delete_contact

        # Call under test and asserts
        await self.user_service.delete_account(test_entity.document_id)

        # Deleted user contacts
        mock_service.delete_contact.assert_called_with(test_entity.document_id, test_entity.contacts[0])
        # Delete user document
        self.mock_user_repo.delete.assert_called_with(document_id=test_entity.document_id)
        # Delete user status
        self.mock_status_repo.delete.assert_called_with(document_id=test_entity.document_id)

    async def test_create_group_should_update_user_document(self):
        user, group_name, members, picture = "testuser", "groupname", [], self.storage_settings.default_picture
        group_info = GroupInfo(
            id=1,
            name=group_name,
            image_ref=picture,
            contacts=members
        )

        self.mock_user_repo.create_group.return_value = group_info

        # Call under test and asserts
        res_id = await self.user_service.create_group(user, group_name, members)

        self.mock_user_repo.create_group.assert_called_with(user, group_name, members, picture)
        assert res_id == group_info.id

    async def test_get_user_groups_should_return_ok(self):
        user, group_name, members, picture = "testuser", "groupname", [], self.storage_settings.default_picture
        group_info = GroupInfo(
            id=1,
            name=group_name,
            image_ref=picture,
            contacts=members
        )
        self.mock_user_repo.get_user_groups.return_value = ([group_info], {})

        # Call under test and asserts
        groups = await self.user_service.get_user_groups(user)

        self.mock_user_repo.get_user_groups.assert_called_with(user)
        assert groups == [self.user_service.map_group_to_dto(group_info)]

    async def test_update_user_group_name_should_return_ok(self):
        user, group_name, members, picture = "testuser", "groupname", [], self.storage_settings.default_picture
        group_info = GroupInfo(
            id=1,
            name=group_name,
            image_ref=picture,
            contacts=members
        )
        self.mock_user_repo.get_user_groups.return_value = ([group_info], {})

        new_name = "TestName"

        # Call under test and asserts
        await self.user_service.update_group(user, group_info.id, new_name, None)

        group_info.name = new_name

        self.mock_user_repo.update_user_groups.assert_called_with(user, [group_info])

    async def test_delete_user_group_should_return_ok(self):
        user, group_name, members, picture = "testuser", "groupname", [], self.storage_settings.default_picture
        group_info = GroupInfo(
            id="testgroup",
            name=group_name,
            image_ref=picture,
            contacts=members
        )
        self.mock_user_repo.get_user_groups.return_value = ([group_info], {})

        # Call under test and asserts
        await self.user_service.delete_group(uid=user, group_id=group_info.id)

        self.mock_user_repo.update_user_groups.assert_called_with(user_id=user, user_groups=[])

    async def test_update_user_group_members_should_validate_if_user_is_contact(self):
        user, group_name, members, picture = "testuser", "groupname", [], self.storage_settings.default_picture
        test_user = UserEntity(
            document_id="uid",
            name="name",
            email="email",
            phone="phone",
            image_ref="image"
        )
        test_contact = "TestName"
        test_user.contacts = [test_contact]
        group_info = GroupInfo(
            id=1,
            name=group_name,
            image_ref=picture,
            contacts=members
        )
        self.mock_user_repo.get_user_groups.return_value = ([group_info], test_user)

        # Call under test and asserts
        await self.user_service.update_group(user, group_info.id, None, [test_contact], "image_2")

        group_info.contacts = [test_contact]
        group_info.image_ref = "image_2"

        self.mock_user_repo.update_user_groups.assert_called_with(user, [group_info])

        exception = None

        try:
            await self.user_service.update_group(user, group_info.id, None, ["no_friend"])
        except NotFoundException as e:
            exception = e

        assert exception is not None

    async def test_get_user_group_should_return_ok_or_not_found(self):
        user, group_name, members, picture = "testuser", "groupname", [], self.storage_settings.default_picture
        group_info = GroupInfo(
            id="1",
            name=group_name,
            image_ref=picture,
            contacts=members
        )
        self.mock_user_repo.get_user_groups.return_value = ([group_info], {})

        # Call under test and asserts
        group = await self.user_service.get_user_group(user, group_id="1")

        self.mock_user_repo.get_user_groups.assert_called_with(user)
        assert group == self.user_service.map_group_to_dto(group_info)

        # Call Exception under test and asserts
        exception = None
        try:
            await self.user_service.get_user_group(user, group_id="Invalid")
        except NotFoundException as e:
            exception = e

        self.mock_user_repo.get_user_groups.assert_called_with(user)
        assert exception is not None

    async def test_update_user_group_should_upload_new_file_and_delete_old(self):
        user, group_name, members, picture = "testuser", "groupname", [], self.storage_settings.default_picture + "old"
        group_info = GroupInfo(
            id="1",
            name=group_name,
            image_ref=picture,
            contacts=members
        )
        self.mock_user_repo.get_user_groups.return_value = ([group_info], {})
        self.mock_file_repository.upload_group_image.return_value = "test/ref"

        # Call under test and asserts
        group = await self.user_service.update_group_picture(user=user, group=group_info.id,
                                                             extension=".jpeg", picture=TEST_IMAGE_BYTES)

        # Asserts
        self.mock_file_repository.upload_group_image.assert_called_with(filename=f'{user}_{group_info.id}.jpeg',
                                                                        data=TEST_RESIZED_BYTES)
        self.mock_file_repository.delete.assert_called_with(reference=picture)

    async def test_handle_notifications_response_should_delete_invalid_tokens(self):
        good_result = SendResponse(resp={"name": "test"}, exception=None)
        bad_result = SendResponse(resp={"name": "test"}, exception=Exception("Test"))
        results = [good_result, bad_result]
        good_token = "good_token"
        bad_token = "bad_token"
        tokens = [good_token, bad_token]
        user_id = "test_user_id"

        # Call under tests
        await self.user_service.handle_notification_results(results=results, tokens=tokens, user_id=user_id)

        # Asserts
        self.mock_user_repo.remove_notifications_tokens.assert_called_with(tokens=["bad_token"], user_id=user_id)


if __name__ == "__main__":
    unittest.main()
