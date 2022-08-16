import unittest
from unittest import TestCase, IsolatedAsyncioTestCase
from unittest.mock import Mock, MagicMock

from app.business.wayat_management.services.user import UserService, map_to_dto
from app.common.infra.firebase import FirebaseAuthenticatedUser
from app.domain.wayat_management.models.user import UserEntity
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository


class UserServiceTests(IsolatedAsyncioTestCase):

    async def asyncSetUp(self):
        self.mock_user_repo = MagicMock(UserRepository)
        self.mock_status_repo = MagicMock(StatusRepository)
        self.user_service = UserService(self.mock_user_repo, self.mock_status_repo)

    async def test_get_user_that_not_exists_should_create_it(self):
        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_url=test_data.picture
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
            image_url=test_data.picture
        )
        self.mock_status_repo.initialize.assert_called_with(test_data.uid)

        assert is_new_user
        assert result_dto == map_to_dto(test_entity)

    async def test_get_user_that_exists_should_return_it(self):
        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
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
        assert result_dto == map_to_dto(test_entity)

    async def test_update_user_should_only_accept_valid_params(self):
        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_url=test_data.picture
        )

        test_update_valid = {
            "name": test_data.name,
            "phone": test_data.phone
        }

        test_update_with_invalid_keys = {
            "name": test_data.name,
            "phone": test_data.phone,
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
                return None

        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_url=test_data.picture
        )

        self.mock_user_repo.get.side_effect = mocking_get_user

        # Call to be tested
        await self.user_service.add_contacts(uid=test_data.uid, users=["test-friend", "invalid"])

        # Asserts
        self.mock_user_repo.create_friend_request.assert_called_with(test_data.uid, [test_entity.document_id])

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
        self.assertCountEqual(user_dtos, [map_to_dto(test_entity)])
        self.mock_user_repo.find_by_phone.assert_called_with(phones=[test_entity.phone])

    async def test_get_contacts_should_return_user_data(self):
        test_entity = UserEntity(
            document_id="test",
            email="test@test.com",
            image_url="test",
            name="test",
            phone="+34-TEST",
        )
        self.mock_user_repo.get_contacts.return_value = [test_entity]

        # Call to be tested
        user_dtos = await self.user_service.get_contacts("uid")

        # Asserts
        self.assertCountEqual(user_dtos, [map_to_dto(test_entity)])
        self.mock_user_repo.get_contacts.assert_called_with("uid")


if __name__ == "__main__":
    unittest.main()
