from datetime import datetime, timezone, timedelta
from unittest import IsolatedAsyncioTestCase
from unittest.mock import MagicMock, patch

from app.business.wayat_management.services.map import MapService, MapSettings
from app.common.base.base_firebase_repository import GeoPoint
from app.domain.wayat_management.models.user import UserEntity, Location
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository


class MapServiceTests(IsolatedAsyncioTestCase):
    async def asyncSetUp(self) -> None:
        # Mocks
        self.map_settings = MapSettings(update_threshold=30, distance_threshold=2.0)
        self.mock_user_repo = MagicMock(UserRepository)
        self.mock_status_repo = MagicMock(StatusRepository)
        self.map_service = MapService(
            self.mock_user_repo,
            self.mock_status_repo,
            self.map_settings,
        )

        # Mock entities
        # User1 and User2 are mutual contacts
        # User1 and User3 are mutual contacts
        # User2 is not a contact of User3
        self.mock_entities = {
            "user_1": UserEntity(
                document_id="user_1",
                name="User1",
                email="user1@test.com",
                phone="+34-TEST-1",
                contacts=["user_2", "user_3"],
            ),
            "user_2": UserEntity(
                document_id="user_2",
                name="User2",
                email="user2@test.com",
                phone="+34-TEST-2",
                contacts=["user_1"],
            ),
            "user_3": UserEntity(
                document_id="user_3",
                name="User3",
                email="user3@test.com",
                phone="+34-TEST-3",
                contacts=["user_1"],
            )
        }

    async def test_update_location_when_no_map_open_should_not_set_active(self):
        # Mocking
        self.mock_user_repo.find_contacts_with_map_open.return_value = []
        uid = self.mock_entities["user_1"].document_id

        # Call to be tested
        await self.map_service.update_location(
            uid=uid,
            latitude=0.0,
            longitude=0.0,
        )

        # Asserts
        self.mock_status_repo.set_active.assert_called_with(uid, False)

    async def test_update_location_when_none_in_range_should_not_set_active(self):
        # Mocking
        # User2 is aprox 3 km away from (0,0)
        self.mock_entities["user_2"].location = Location(
            last_updated=datetime.now(),
            value=GeoPoint.validate_geopoint((0, 0.03))
        )
        self.mock_user_repo.find_contacts_with_map_open.return_value = [self.mock_entities["user_2"]]
        uid = self.mock_entities["user_1"].document_id

        # Call to be tested
        await self.map_service.update_location(
            uid=uid,
            latitude=0.0,
            longitude=0.0,
        )

        # Asserts
        self.mock_status_repo.set_active.assert_called_with(uid, False)

    async def test_update_location_when_friend_in_range_should_set_active(self):
        # Mocking
        # User2 is aprox 1 km away from (0,0)
        self.mock_entities["user_2"].location = Location(
            last_updated=datetime.now(),
            value=GeoPoint.validate_geopoint((0, 0.01))
        )
        self.mock_user_repo.find_contacts_with_map_open.return_value = [self.mock_entities["user_2"]]
        uid = self.mock_entities["user_1"].document_id

        # Call to be tested
        await self.map_service.update_location(
            uid=uid,
            latitude=0.0,
            longitude=0.0,
        )

        # Asserts
        self.mock_status_repo.set_active.assert_called_with(uid, True)

    async def test_update_location_should_update_location_in_repository(self):
        # Call to test
        await self.map_service.update_location("uid_1", 0.1, 0.2)

        # Asserts
        self.mock_user_repo.update_user_location.assert_called_with("uid_1", 0.1, 0.2)

