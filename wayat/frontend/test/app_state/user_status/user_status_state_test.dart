import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/location/share_location_service.dart';
import 'package:wayat/services/status/user_status_service_impl.dart';

import 'user_status_state_test.mocks.dart';

@GenerateMocks(
    [UserStatusService, LocationState, ShareLocationService, FirebaseFirestore])
void main() async {
  LocationState mockLocationState = MockLocationState();
  setUpAll(() {
    GetIt.I.registerSingleton<LocationState>(mockLocationState);
  });
  test("Initial state is correct", () {
    UserStatusState userStatusState =
        UserStatusState(userStatusService: MockUserStatusService());
    expect(userStatusState.contacts, []);
    expect(userStatusState.locationMode, ShareLocationMode.passive);
  });

  test("Set Contact List is correct", () {
    UserStatusState userStatusState =
        UserStatusState(userStatusService: MockUserStatusService());
    expect(userStatusState.contacts, []);

    List<ContactLocation> newContactList =
        _generateContacts(["TestA", "TestB", "TestC"]);

    userStatusState.setContactList(newContactList);

    expect(userStatusState.contacts, newContactList);
  });

  test("Set Location mode is correct", () {
    UserStatusService mockUserStatusService = MockUserStatusService();
    ShareLocationService mockShareLocationService = MockShareLocationService();
    UserStatusState userStatusState =
        UserStatusState(userStatusService: mockUserStatusService);
    mockLocationState.shareLocationService = MockShareLocationService();
    when(mockLocationState.shareLocationService)
        .thenReturn(mockShareLocationService);
    when(mockShareLocationService
            .setShareLocationMode(ShareLocationMode.active))
        .thenReturn(null);

    expect(userStatusState.locationMode, ShareLocationMode.passive);

    userStatusState.setLocationMode(ShareLocationMode.active);

    expect(userStatusState.locationMode, ShareLocationMode.active);
  });

  test("Initialize listener sets up the service listener", () {
    UserStatusService mockUserStatusService = MockUserStatusService();
    UserStatusState userStatusState =
        UserStatusState(userStatusService: mockUserStatusService);
    when(mockUserStatusService.setUpListener(
            onContactsRefUpdate: userStatusState.onContactsRefUpdateCallback,
            onLocationModeUpdate: userStatusState.onLocationModeUpdateCallback))
        .thenAnswer((_) => Future.value(null));

    userStatusState.initializeListener();

    verify(mockUserStatusService.setUpListener(
            onContactsRefUpdate: userStatusState.onContactsRefUpdateCallback,
            onLocationModeUpdate: userStatusState.onLocationModeUpdateCallback))
        .called(1);
  });

  test("ContactRefs callback sets Contact List", () {
    UserStatusState userStatusState =
        UserStatusState(userStatusService: MockUserStatusService());
    expect(userStatusState.contacts, []);

    List<ContactLocation> newContactList =
        _generateContacts(["TestA", "TestB", "TestC"]);

    userStatusState.onContactsRefUpdateCallback(newContactList);

    expect(userStatusState.contacts, newContactList);
  });

  test("LocationMode callback sets location mode", () {
    UserStatusService mockUserStatusService = MockUserStatusService();
    ShareLocationService mockShareLocationService = MockShareLocationService();
    UserStatusState userStatusState =
        UserStatusState(userStatusService: mockUserStatusService);
    mockLocationState.shareLocationService = MockShareLocationService();
    when(mockLocationState.shareLocationService)
        .thenReturn(mockShareLocationService);
    when(mockShareLocationService
            .setShareLocationMode(ShareLocationMode.active))
        .thenReturn(null);

    expect(userStatusState.locationMode, ShareLocationMode.passive);

    userStatusState.onLocationModeUpdateCallback(ShareLocationMode.active);

    expect(userStatusState.locationMode, ShareLocationMode.active);
  });
}

ContactLocation _contactFactory(String contactName) {
  return ContactLocation(
    shareLocation: true,
    available: true,
    id: "id $contactName",
    name: contactName,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
    address: '',
    lastUpdated: DateTime.now(),
    latitude: 1,
    longitude: 1,
  );
}

List<ContactLocation> _generateContacts(List<String> names) {
  return names.map((name) => _contactFactory(name)).toList();
}
