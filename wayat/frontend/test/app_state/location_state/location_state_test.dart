import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/location/share_location_service.dart';
import 'package:wayat/services/location/share_location_service_factory.dart';

import 'location_state_test.mocks.dart';

@GenerateMocks([
  ShareLocationService,
  UserStatusState,
  SessionState,
  ShareLocationServiceFactory
])
void main() async {
  ShareLocationService mockShareLocationService = MockShareLocationService();
  UserStatusState mockUserStatusState = MockUserStatusState();
  SessionState mockSessionState = MockSessionState();
  MyUser testUser = _generateMyUser(true);

  setUpAll(() {
    GetIt.I.registerSingleton<UserStatusState>(mockUserStatusState);
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    when(mockSessionState.currentUser).thenReturn(testUser);
  });

  test("Initialize is correct", () async {
    when(mockUserStatusState.locationMode).thenReturn(ShareLocationMode.active);

    ShareLocationServiceFactory mockLocationServiceFactory =
        MockShareLocationServiceFactory();

    LocationState locationState = LocationState();

    when(mockLocationServiceFactory.create(
            shareLocationMode: ShareLocationMode.active,
            shareLocationEnabled: testUser.shareLocationEnabled,
            onLocationChanged: locationState.onLocationChanged))
        .thenAnswer((_) => Future.value(mockShareLocationService));

    when(mockUserStatusState.initializeListener())
        .thenAnswer((_) => Future.value(null));

    when(mockShareLocationService.getCurrentLocation())
        .thenReturn(LocationData.fromMap({'latitude': 1.0, 'longitude': 1.0}));

    expect(locationState.currentLocation, const LatLng(0, 0));

    await locationState.initialize(
        locationServiceFactory: mockLocationServiceFactory);

    verify(mockLocationServiceFactory.create(
            shareLocationMode: ShareLocationMode.active,
            shareLocationEnabled: testUser.shareLocationEnabled,
            onLocationChanged: locationState.onLocationChanged))
        .called(1);

    verify(mockUserStatusState.initializeListener()).called(1);

    expect(locationState.currentLocation, const LatLng(1, 1));
  });

  test("SetShareLocationEnabled changes the state and updates the server", () {
    bool oldEnabled = false;
    bool newEnabled = true;

    LocationState locationState = LocationState();
    locationState.shareLocationEnabled = oldEnabled;

    expect(locationState.shareLocationEnabled, oldEnabled);

    locationState.shareLocationService = MockShareLocationService();
    when(locationState.shareLocationService.setShareLocationEnabled(newEnabled))
        .thenReturn(null);

    locationState.setShareLocationEnabled(newEnabled);

    expect(locationState.shareLocationEnabled, newEnabled);
    verify(locationState.shareLocationService
            .setShareLocationEnabled(newEnabled))
        .called(1);
  });

  test("SetCurrentLocation updates the location", () {
    LocationState locationState = LocationState();
    expect(locationState.currentLocation, const LatLng(0, 0));
    locationState.setCurrentLocation(const LatLng(1, 1));
    expect(locationState.currentLocation, const LatLng(1, 1));
  });

  test("OnLocationChaged callback updates the current location", () {
    LocationState locationState = LocationState();
    expect(locationState.currentLocation, const LatLng(0, 0));
    locationState.onLocationChanged(const LatLng(1, 1));
    expect(locationState.currentLocation, const LatLng(1, 1));
  });
}

MyUser _generateMyUser(bool shareLocationEnabled) {
  return MyUser(
      id: "id",
      name: "name",
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phone: "123",
      onboardingCompleted: true,
      shareLocationEnabled: shareLocationEnabled);
}
