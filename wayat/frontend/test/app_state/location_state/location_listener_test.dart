import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/location_state/receive_location/receive_location_state.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/share_location/share_location_service.dart';
import 'package:wayat/services/location_listener/location_listener_service.dart';

import 'location_listener_test.mocks.dart';

@GenerateMocks([
  LocationListenerService,
  ShareLocationState,
  ReceiveLocationState,
  ShareLocationService,
  FirebaseFirestore,
  UserState
])
void main() async {
  ShareLocationState mockLocationState = MockShareLocationState();
  UserState mockUserState = MockUserState();
  setUpAll(() {
    GetIt.I.registerSingleton<ShareLocationState>(mockLocationState);
    GetIt.I.registerSingleton<UserState>(mockUserState);

    when(mockUserState.currentUser).thenReturn(_userFactory());
  });
  test("Initial state is correct", () {
    LocationListener locationListener = LocationListener(
        locationListenerService: MockLocationListenerService());
    expect(locationListener.receiveLocationState.contacts, []);
    expect(locationListener.shareLocationState.activeShareMode, true);
  });

  test("Set Contact List is correct", () {
    LocationListener locationListener = LocationListener(
        locationListenerService: MockLocationListenerService());
    expect(locationListener.receiveLocationState.contacts, []);

    List<ContactLocation> newContactList =
        _generateContacts(["TestA", "TestB", "TestC"]);

    locationListener.receiveLocationState.setContactList(newContactList);

    expect(locationListener.receiveLocationState.contacts, newContactList);
  });

  test("Initialize listener sets up the service listener", () {
    LocationListenerService mockLocationListenerService =
        MockLocationListenerService();
    LocationListener locationListener =
        LocationListener(locationListenerService: mockLocationListenerService);
    when(mockLocationListenerService.setUpListener(
            onContactsRefUpdate: locationListener.onContactsRefUpdateCallback,
            onLocationModeUpdate:
                locationListener.onLocationModeUpdateCallback))
        .thenAnswer((_) => Future.value(null));

    locationListener.initialize();

    verify(mockLocationListenerService.setUpListener(
            onContactsRefUpdate: locationListener.onContactsRefUpdateCallback,
            onLocationModeUpdate:
                locationListener.onLocationModeUpdateCallback))
        .called(1);
  });

  test("ContactRefs callback sets Contact List", () {
    LocationListener locationListener = LocationListener(
        locationListenerService: MockLocationListenerService());
    expect(locationListener.receiveLocationState.contacts, []);

    List<ContactLocation> newContactList =
        _generateContacts(["TestA", "TestB", "TestC"]);

    locationListener.onContactsRefUpdateCallback(newContactList);

    expect(locationListener.receiveLocationState.contacts, newContactList);
  });

  test("LocationMode callback sets location mode", () {
    LocationListenerService mockLocationListenerService =
        MockLocationListenerService();
    ShareLocationService mockShareLocationService = MockShareLocationService();
    LocationListener locationListener =
        LocationListener(locationListenerService: mockLocationListenerService);
    mockLocationState.shareLocationService = MockShareLocationService();
    when(mockLocationState.shareLocationService)
        .thenReturn(mockShareLocationService);
    when(mockShareLocationService.setActiveShareMode(false)).thenReturn(null);
    locationListener.shareLocationState.shareLocationService =
        mockShareLocationService;

    expect(locationListener.shareLocationState.activeShareMode, true);

    locationListener.onLocationModeUpdateCallback(false);

    expect(locationListener.shareLocationState.activeShareMode, false);
  });
}

ContactLocation _contactFactory(String contactName) {
  return ContactLocation(
    shareLocationTo: true,
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

MyUser _userFactory() {
  return MyUser(
    id: "id",
    name: "name",
    onboardingCompleted: true,
    shareLocationEnabled: true,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phonePrefix: "+34",
    phone: "123",
  );
}

List<ContactLocation> _generateContacts(List<String> names) {
  return names.map((name) => _contactFactory(name)).toList();
}
