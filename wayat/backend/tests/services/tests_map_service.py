from datetime import datetime, timezone, timedelta
from unittest import IsolatedAsyncioTestCase, skip
from unittest.mock import MagicMock, patch, call

from app.business.wayat_management.services.map import MapService, MapSettings
from app.common.infra.gcp.base_firebase_repository import GeoPoint
from app.domain.wayat_management.models.status import ContactRefInfo
from app.domain.wayat_management.models.user import UserEntity, Location
from app.domain.wayat_management.repositories.status import StatusRepository
from app.domain.wayat_management.repositories.user import UserRepository


class MapServiceTests(IsolatedAsyncioTestCase):
    async def asyncSetUp(self) -> None:
        # Mocks
        self.map_settings = MapSettings(update_threshold=30, distance_threshold=2.0, valid_until_threshold=30,
                                        max_time_without_update=1200)
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
                location_shared_with=["user_2", "user_3"]
            ),
            "user_2": UserEntity(
                document_id="user_2",
                name="User2",
                email="user2@test.com",
                phone="+34-TEST-2",
                contacts=["user_1"],
                location_shared_with=["user_1"]
            ),
            "user_3": UserEntity(
                document_id="user_3",
                name="User3",
                email="user3@test.com",
                phone="+34-TEST-3",
                contacts=["user_1"],
                location_shared_with=["user_1"]
            )
        }

    async def test_update_location_should_update_location_in_repository(self):
        # Call to test
        await self.map_service.update_location("uid_1", 0.1, 0.2, "Gulf of Guinea")

        # Asserts
        self.mock_user_repo.update_user_location.assert_called_with("uid_1", 0.1, 0.2, "Gulf of Guinea")

    async def test_update_location_when_no_map_open_should_not_set_active(self):
        # Mocking
        self.mock_user_repo.find_contacts_with_map_open.return_value = []
        uid = self.mock_entities["user_1"].document_id

        # Call to be tested
        await self.map_service.update_location(
            uid=uid,
            latitude=0.0,
            longitude=0.0,
            address="Gulf of Guinea",
        )

        # Asserts
        self.mock_status_repo.set_active.assert_called_with(uid, False)

    async def test_update_location_when_none_in_range_should_not_set_active(self):
        # Mocking
        # User2 is aprox 3 km away from (0,0)
        self.mock_entities["user_2"].location = Location(
            last_updated=datetime.now(timezone.utc),
            value=GeoPoint.validate_geopoint((0, 0.03)),
            address="Gulf of Guinea",
        )
        self.mock_user_repo.find_contacts_with_map_open.return_value = [self.mock_entities["user_2"]]
        uid = self.mock_entities["user_1"].document_id

        # Call to be tested
        await self.map_service.update_location(
            uid=uid,
            latitude=0.0,
            longitude=0.0,
            address="Gulf of Guinea",
        )

        # Asserts
        self.mock_status_repo.set_active.assert_called_with(uid, False)

    async def test_update_location_when_friend_in_range_should_set_active(self):
        # Mocking
        # User2 is aprox 1 km away from (0,0)
        self.mock_entities["user_2"].location = Location(
            last_updated=datetime.now(timezone.utc),
            value=GeoPoint.validate_geopoint((0, 0.01)),
            address="Gulf of Guinea",
        )
        self.mock_user_repo.find_contacts_with_map_open.return_value = [self.mock_entities["user_2"]]
        uid = self.mock_entities["user_1"].document_id

        # Call to be tested
        await self.map_service.update_location(
            uid=uid,
            latitude=0.0,
            longitude=0.0,
            address="Gulf of Guinea",
        )

        # Asserts
        self.mock_status_repo.set_active.assert_called_with(uid, True)

    @patch("app.business.wayat_management.services.map.datetime")
    async def test_update_location_should_update_all_contacts_with_map_open(self, datetime_mock):
        # Mocks
        # User2 and User3 have the map open
        # User2 is in range, User3 isn't. However, both should receive the update
        self.mock_entities["user_1"].location = Location(
            last_updated=datetime.now(timezone.utc),
            value=GeoPoint.validate_geopoint((0, 0.01)),
            address="TestLocationUser1"
        )
        self.mock_entities["user_2"].location = Location(
            last_updated=datetime.now(timezone.utc),
            value=GeoPoint.validate_geopoint((0, 0.01)),
            address="TestLocationUser2"
        )
        self.mock_entities["user_3"].location = Location(
            last_updated=datetime.now(timezone.utc),
            value=GeoPoint.validate_geopoint((0, 0.03)),
            address="TestLocationUser3"
        )
        # Mock the last_status_update field so that both contacts are updated
        now_timestamp = datetime(2022, 8, 16, 12, 0, 0, tzinfo=timezone.utc)
        old_enough_timestamp = now_timestamp - timedelta(seconds=(self.map_settings.update_threshold + 1))
        self.mock_entities["user_2"].last_status_update = old_enough_timestamp
        self.mock_entities["user_3"].last_status_update = old_enough_timestamp
        self.mock_entities["user_1"].location.last_updated = now_timestamp
        self.mock_entities["user_2"].location.last_updated = now_timestamp
        self.mock_entities["user_3"].location.last_updated = now_timestamp
        datetime_mock.now.return_value = now_timestamp

        def mocking_get_user_location(user_id: str):
            return self.mock_entities[user_id].location, self.mock_entities[user_id].location_shared_with

        # Mock the user repo
        self.mock_user_repo.find_contacts_with_map_open.return_value = [self.mock_entities["user_2"],
                                                                        self.mock_entities["user_3"]]
        self.mock_user_repo.get_user_location.side_effect = mocking_get_user_location

        uid = self.mock_entities["user_1"].document_id

        # Expected calls args
        contact_refs_1 = [ContactRefInfo(uid=self.mock_entities["user_1"].document_id,
                                         last_updated=self.mock_entities["user_1"].location.last_updated,
                                         location=self.mock_entities["user_1"].location.value,
                                         address=self.mock_entities["user_1"].location.address)]

        # Call under test
        await self.map_service.update_location(uid, 0.0, 0.0, "Test")

        # Asserts
        self.mock_user_repo.update_last_status.assert_has_calls([call("user_2"), call("user_3")], any_order=True)
        self.mock_status_repo.set_contact_refs.assert_has_calls([call("user_2", contact_refs_1),
                                                                 call("user_3", contact_refs_1)], any_order=True)

        # Mock for old updated location test case
        very_old_timestamp = now_timestamp - timedelta(hours=2)
        self.mock_entities["user_1"].location.last_updated = very_old_timestamp

        # Call under test
        await self.map_service.update_location(uid, 0.0, 0.0, "Test")

        # Asserts
        self.mock_user_repo.update_last_status.assert_has_calls([call("user_2"), call("user_3")], any_order=True)
        self.mock_status_repo.set_contact_refs.assert_has_calls([call("user_2", []),
                                                                 call("user_3", [])], any_order=True)

    async def test_update_map_status_when_close_map_should_update_map_info(self):
        uid = "Test"

        # Call to be tested
        await self.map_service.update_map_status(uid, False)

        # Asserts
        self.mock_user_repo.update_map_info.assert_called_with(uid, False)

    @patch("app.business.wayat_management.services.map.get_current_time")
    async def test_update_map_status_when_open_map_that_was_open_should_update_map_info(self, datetime_mock):
        uid = "user_1"

        now_timestamp = datetime(2022, 8, 16, 12, 0, 0, tzinfo=timezone.utc)
        datetime_mock.return_value = now_timestamp

        # Mocks
        self.mock_entities[uid].map_open = True
        self.mock_user_repo.get_or_throw.return_value = self.mock_entities[uid]

        # Call to be tested
        await self.map_service.update_map_status(uid, True)

        # Asserts
        self.mock_user_repo.update_map_info \
            .assert_called_with(uid, True, now_timestamp + timedelta(seconds=self.map_settings.valid_until_threshold))

    @patch("app.business.wayat_management.services.map.get_current_time")
    async def test_update_map_status_when_open_map_closed_should_update_map_info_and_regenerate(self, datetime_mock):
        uid = "user_1"

        now_timestamp = datetime(2022, 8, 16, 12, 0, 0, tzinfo=timezone.utc)
        datetime_mock.return_value = now_timestamp

        # Mocks
        mock_map_service = MagicMock(MapService)
        self.mock_entities[uid].map_open = False
        self.mock_user_repo.get_or_throw.return_value = self.mock_entities[uid]
        self.map_service.regenerate_map_status = mock_map_service.regenerate_map_status

        # Call to be tested
        await self.map_service.update_map_status(uid, True)

        # Asserts
        self.mock_user_repo.update_map_info \
            .assert_called_with(uid=uid, map_open=True, map_valid_until=now_timestamp +
                                                                        timedelta(
                                                                            seconds=self.map_settings
                                                                            .valid_until_threshold))
        mock_map_service.regenerate_map_status.assert_called_with(user=self.mock_entities[uid])

    async def test_overload_force_status_update(self):
        uid = "user_1"
        # Mocks
        mock_map_service = MagicMock(MapService)
        # self.mock_entities[uid].map_open = False
        self.mock_user_repo.get_or_throw.return_value = self.mock_entities[uid]
        self.map_service.regenerate_map_status = mock_map_service.regenerate_map_status

        # Call to be tested
        await self.map_service.force_status_update(uid=uid, force_contacts_active=False)

        mock_map_service.regenerate_map_status.assert_called_with(user=self.mock_entities[uid])

        exception = None
        try:
            await self.map_service.force_status_update(force_contacts_active=False)
        except ValueError as e:
            exception = e

        assert exception is not None

    async def test_overload_regenerate_map_status(self):
        uid = "user_1"
        # Mocks
        mock_map_service = MagicMock(MapService)
        self.mock_entities[uid].contacts = []
        self.mock_user_repo.get_or_throw.return_value = self.mock_entities[uid]
        self.map_service._create_contact_ref = mock_map_service._create_contact_ref

        # Call to be tested
        await self.map_service.regenerate_map_status(uid=uid)

        self.mock_user_repo.update_last_status.assert_called_with(uid)

        exception = None
        try:
            await self.map_service.regenerate_map_status()
        except ValueError as e:
            exception = e

        assert exception is not None

    async def test_none_values(self):
        uid = "user_1"
        # Mocks
        self.mock_user_repo.get_user_location.return_value = None, None

        # Call to be tested
        res = await self.map_service._create_contact_ref(contact_uid=uid, self_user=self.mock_entities[uid])
        assert res is None

        res = self.map_service._in_range(latitude=0, longitude=0, contact_location=None)
        assert res is False

        res = self.map_service._should_show(None)
        assert res is False

    async def test_vanish_user_should_regenerate_maps_containing_user(self):
        uid = "user_1"
        # Mocks
        mock_map_service = MagicMock(MapService)
        self.map_service.regenerate_map_status = mock_map_service.regenerate_map_status
        self.mock_status_repo.find_maps_containing_user.return_value = ["test"]

        # Call to be tested
        res = await self.map_service.regenerate_maps_containing_user(uid=uid)
        mock_map_service.regenerate_map_status.assert_called_with(uid="test")