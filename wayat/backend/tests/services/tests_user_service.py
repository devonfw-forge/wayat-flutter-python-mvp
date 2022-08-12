import unittest
from unittest import TestCase, IsolatedAsyncioTestCase
from unittest.mock import Mock, MagicMock

from app.business.wayat_management.services.user import UserService, map_to_dto
from app.common.infra.firebase import FirebaseAuthenticatedUser
from app.domain.wayat_management.models.user import UserEntity
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository


class UserServiceTests(IsolatedAsyncioTestCase):

    async def test_get_user_that_not_exists_should_create_it(self):
        mock_user_repo = MagicMock(UserRepository)
        mock_status_repo = MagicMock(StatusRepository)
        user_service = UserService(mock_user_repo, mock_status_repo)

        test_data = FirebaseAuthenticatedUser(uid="test", email="test@email.es", roles=[], picture="test", name="test")
        test_entity = UserEntity(
            document_id=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_url=test_data.picture
        )

        mock_user_repo.get.return_value = None
        mock_user_repo.create.return_value = test_entity

        # Call to be tested
        result_dto, is_new_user = await user_service.get_or_create(test_data.uid, test_data)

        # Asserts
        mock_user_repo.create.assert_called_with(
            uid=test_data.uid,
            name=test_data.name,
            email=test_data.email,
            phone=test_data.phone,
            image_url=test_data.picture
        )
        mock_status_repo.initialize.assert_called_with(test_data.uid)

        assert is_new_user
        assert result_dto == map_to_dto(test_entity)


if __name__ == "__main__":
    unittest.main()
