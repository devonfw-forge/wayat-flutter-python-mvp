import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/ip_location/ip_location_service.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/google_maps_service/address_response/address.dart';
import 'package:wayat/services/google_maps_service/address_response/address_component.dart';
import 'package:wayat/services/google_maps_service/address_response/address_response.dart';
import 'package:wayat/services/share_location/background_location_exception.dart';
import 'package:wayat/services/share_location/no_location_service_exception.dart';
import 'package:wayat/services/share_location/rejected_location_exception.dart';
import 'package:wayat/services/share_location/share_location_service_impl.dart';

import 'share_location_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpProvider>(),
  MockSpec<Client>(),
  MockSpec<Location>(),
  MockSpec<Stream>(),
  MockSpec<StreamSubscription>(),
])
@GenerateMocks([PlatformService, IPLocationService])
void main() {
  MockHttpProvider mockHttpProvider = MockHttpProvider();
  MockClient mockClient = MockClient();
  MockPlatformService mockPlatformService = MockPlatformService();
  MockIPLocationService mockIPLocationService = MockIPLocationService();

  setUpAll(() async {
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
    GetIt.I.registerSingleton<PlatformService>(mockPlatformService);
    GetIt.I.registerSingleton<IPLocationService>(mockIPLocationService);

    when(mockHttpProvider.client).thenReturn(mockClient);
    when(mockClient.get(any))
        .thenAnswer((_) async => exampleGoogleMapsResponse());
  });

  test("Check Location Permissions throw the correct exceptions", () async {
    MockLocation mockLocation = MockLocation();

    when(mockLocation.serviceEnabled()).thenAnswer((_) async => false);
    when(mockLocation.requestService()).thenAnswer((_) async => false);

    try {
      await ShareLocationServiceImpl.checkLocationPermissions(
          loc: mockLocation);
      fail("Should have thrown [NoLocationServiceException]");
    } on NoLocationServiceException {
      expect(true, true);
    }

    when(mockLocation.serviceEnabled()).thenAnswer((_) async => true);
    when(mockLocation.hasPermission())
        .thenAnswer((_) async => PermissionStatus.denied);
    when(mockLocation.requestPermission())
        .thenAnswer((_) async => PermissionStatus.denied);

    try {
      await ShareLocationServiceImpl.checkLocationPermissions(
          loc: mockLocation);
      fail("Should have thrown [RejectedLocationException]");
    } on RejectedLocationException {
      expect(true, true);
    }

    when(mockLocation.hasPermission())
        .thenAnswer((_) async => PermissionStatus.granted);
    when(mockLocation.isBackgroundModeEnabled()).thenAnswer((_) async => false);
    when(mockLocation.enableBackgroundMode(enable: true))
        .thenThrow(PlatformException(code: "PERMISSION_DENIED"));

    try {
      await ShareLocationServiceImpl.checkLocationPermissions(
          loc: mockLocation);
      fail("Should have thrown [BackgroundLocationException]");
    } on BackgroundLocationException {
      expect(true, true);
    }
  });

  test(
      "MangeLocationChange: active mode does not share location if the distance is not enough",
      () {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();

    service.activeShareMode = true;
    service.lastShared = DateTime(1970);
    LocationData currentLocation = getLocationData(1.0, 1.0);
    service.currentLocation = currentLocation;
    LocationData nextLocation = getLocationData(1.0, 1.0);

    service.manageLocationChange(nextLocation);

    // The date has not changed because active only updates based on distance
    expect(service.lastShared, DateTime(1970));
    verifyNever(mockHttpProvider.sendPostRequest(any, any));
  });

  test(
      "MangeLocationChange: active mode always shares location if the distance is enough",
      () async {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();

    service.changeLocationStateCallback = (latlgn) => log('location changed');
    service.activeShareMode = true;
    service.lastShared = DateTime.now();
    LocationData currentLocation = getLocationData(1.0, 1.0);
    service.currentLocation = currentLocation;
    LocationData nextLocation = getLocationData(1.1, 1.1);

    await service.manageLocationChange(nextLocation);

    expect(service.currentLocation, nextLocation);
    verify(mockHttpProvider.sendPostRequest(APIContract.updateLocation, any))
        .called(1);
  });

  test(
      "MangeLocationChange: passive mode always shares location if the distance is enough",
      () async {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();

    service.changeLocationStateCallback = (latlgn) => log('location changed');
    service.activeShareMode = false;
    service.lastShared = DateTime.now();
    LocationData currentLocation = getLocationData(1.0, 1.0);
    service.currentLocation = currentLocation;
    LocationData nextLocation = getLocationData(1.1, 1.1);

    await service.manageLocationChange(nextLocation);

    expect(service.currentLocation, nextLocation);
    verify(mockHttpProvider.sendPostRequest(APIContract.updateLocation, any))
        .called(1);
  });

  test(
      "MangeLocationChange: passive mode always shares location if the time is enough",
      () async {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();

    service.changeLocationStateCallback = (latlgn) => log('location changed');
    service.activeShareMode = false;
    DateTime fifteenMinutesAgo =
        DateTime.now().subtract(const Duration(minutes: 15));
    service.lastShared = fifteenMinutesAgo;
    LocationData currentLocation = getLocationData(1.0, 1.0);
    service.currentLocation = currentLocation;

    await service.manageLocationChange(currentLocation);

    expect(
        service.lastShared.difference(fifteenMinutesAgo) >=
            const Duration(minutes: 15),
        true);
    verify(mockHttpProvider.sendPostRequest(APIContract.updateLocation, any))
        .called(1);
  });

  test(
      "MangeLocationChange: passive mode does not share location"
      " if time and distance are not enough", () async {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();

    service.changeLocationStateCallback = (latlgn) => log('location changed');
    service.activeShareMode = false;
    service.lastShared = DateTime.now();
    LocationData currentLocation = getLocationData(1.0, 1.0);
    service.currentLocation = currentLocation;

    await service.manageLocationChange(currentLocation);

    verifyNever(
        mockHttpProvider.sendPostRequest(APIContract.updateLocation, any));
  });

  test("Calculate distance has max +-10 meter error", () {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();
    service.currentLocation = getLocationData(1.0, 1.0);

    expect(
        service.calculateDistance(getLocationData(1.00905, 1)) >= 1000 &&
            service.calculateDistance(getLocationData(1.00905, 1)) <= 1010,
        true);
  });

  test("sendLocationToBack sends corect data", () async {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();
    service.changeLocationStateCallback = (latlgn) => log('location changed');
    LocationData locationData = getLocationData(1.0, 1.0);

    await service.sendLocationToBack(getLocationData(1.0, 1.0));

    verify(mockHttpProvider.sendPostRequest(APIContract.updateLocation, {
      "position": {
        "longitude": locationData.longitude,
        "latitude": locationData.latitude,
      },
      "address": ", , "
    })).called(1);
  });

  test("getCurrentLocation is correct", () async {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();
    service.currentLocation = getLocationData(1.0, 1.0);

    expect(service.getCurrentLocation(), service.currentLocation);
    expect(service.getCurrentLocation(), getLocationData(1.0, 1.0));

    service.currentLocation = getLocationData(2.0, 1.0);

    expect(service.getCurrentLocation(), service.currentLocation);
    expect(service.getCurrentLocation(), getLocationData(2.0, 1.0));
  });

  test("setActiveShareMode: if it changes to passive, do not update location ",
      () async {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();
    service.activeShareMode = true;
    service.shareLocationEnabled = true;

    when(mockPlatformService.isWeb).thenReturn(false);

    await service.setActiveShareMode(false);

    expect(service.activeShareMode, false);
    verifyNever(
        mockHttpProvider.sendPostRequest(APIContract.updateLocation, any));
  });

  test("setActiveShareMode: if it changes to active, update location if share ",
      () async {
    when(mockPlatformService.isDesktop).thenReturn(true);
    ShareLocationServiceImpl service = ShareLocationServiceImpl();
    service.location = MockLocation();
    when(service.location.getLocation())
        .thenAnswer((_) async => getLocationData(1.0, 1.0));
    service.changeLocationStateCallback = (latlgn) => log('location changed');
    service.activeShareMode = true;
    service.shareLocationEnabled = true;

    when(mockPlatformService.isWeb).thenReturn(true);

    await service.setActiveShareMode(true);

    expect(service.activeShareMode, true);
    verifyNever(
        mockHttpProvider.sendPostRequest(APIContract.updateLocation, any));

    when(mockPlatformService.isWeb).thenReturn(false);

    await service.setActiveShareMode(true);

    expect(service.activeShareMode, true);
    verifyNever(
            mockHttpProvider.sendPostRequest(APIContract.updateLocation, any))
        .called(0);

    service.shareLocationEnabled = false;

    await service.setActiveShareMode(true);

    expect(service.activeShareMode, true);
    verifyNever(
        mockHttpProvider.sendPostRequest(APIContract.updateLocation, any));
  });

  test("isWebLocationEnabled is correct", () {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();
    service.webLocationPermissions = null;

    expect(service.isWebLocationEnabled(), false);

    service.webLocationPermissions = PermissionStatus.denied;

    expect(service.isWebLocationEnabled(), false);

    service.webLocationPermissions = PermissionStatus.deniedForever;

    expect(service.isWebLocationEnabled(), false);

    service.webLocationPermissions = PermissionStatus.granted;

    expect(service.isWebLocationEnabled(), true);

    service.webLocationPermissions = PermissionStatus.grantedLimited;

    expect(service.isWebLocationEnabled(), true);
  });

  test("setShareLocationEnabled is correct", () async {
    ShareLocationServiceImpl service = ShareLocationServiceImpl();
    service.changeLocationStateCallback = (latlgn) => log('location changed');
    service.location = MockLocation();
    when(service.location.getLocation())
        .thenAnswer((_) async => getLocationData(1.0, 1.0));
    when(service.location.getLocation())
        .thenAnswer((_) async => getLocationData(1.0, 1.0));

    await service.setShareLocationEnabled(false);

    expect(service.shareLocationEnabled, false);
    verify(mockHttpProvider.sendPostRequest(
        APIContract.preferences, {"share_location": false})).called(1);
    verifyNever(
        mockHttpProvider.sendPostRequest(APIContract.updateLocation, any));

    await service.setShareLocationEnabled(true);

    expect(service.shareLocationEnabled, true);
    verify(mockHttpProvider.sendPostRequest(
        APIContract.preferences, {"share_location": true})).called(1);
    verify(mockHttpProvider.sendPostRequest(APIContract.updateLocation, any))
        .called(1);
  });

  test("Create is correct for web with permissions", () async {
    LocationData initialLocation = getLocationData(1.0, 1.0);
    bool activeShareMode = true;
    bool shareLocationEnabled = true;
    changeLocationStateCallback(latlgn) => log('location changed');
    PermissionStatus webPermissionStatus = PermissionStatus.granted;
    MockPlatformService mockPlatformService = MockPlatformService();

    when(mockPlatformService.isWeb).thenReturn(true);
    when(mockPlatformService.isMobile).thenReturn(false);

    ShareLocationServiceImpl service = ShareLocationServiceImpl.build(
        initialLocation,
        activeShareMode,
        shareLocationEnabled,
        changeLocationStateCallback,
        webPermissionStatus,
        loc: MockLocation());

    await Future.delayed(const Duration(seconds: 1));

    verify(mockHttpProvider.sendPostRequest(APIContract.updateLocation, any))
        .called(1);
    expect(service.currentLocation, initialLocation);
    expect(service.activeShareMode, activeShareMode);
    expect(service.shareLocationEnabled, shareLocationEnabled);
    expect(service.changeLocationStateCallback, changeLocationStateCallback);
    expect(service.webLocationPermissions, webPermissionStatus);
    expect(service.platformService, mockPlatformService);
  });

  test("Create is correct for web sharedLocation disabled", () async {
    LocationData initialLocation = getLocationData(1.0, 1.0);
    bool activeShareMode = true;
    bool shareLocationEnabled = false;
    changeLocationStateCallback(latlgn) => log('location changed');
    PermissionStatus webPermissionStatus = PermissionStatus.granted;
    MockPlatformService mockPlatformService = MockPlatformService();

    when(mockPlatformService.isWeb).thenReturn(true);
    when(mockPlatformService.isMobile).thenReturn(false);

    ShareLocationServiceImpl service = ShareLocationServiceImpl.build(
        initialLocation,
        activeShareMode,
        shareLocationEnabled,
        changeLocationStateCallback,
        webPermissionStatus,
        loc: MockLocation());

    await Future.delayed(const Duration(seconds: 1));

    verifyNever(
        mockHttpProvider.sendPostRequest(APIContract.updateLocation, any));
    expect(service.currentLocation, initialLocation);
    expect(service.activeShareMode, activeShareMode);
    expect(service.shareLocationEnabled, shareLocationEnabled);
    expect(service.changeLocationStateCallback, changeLocationStateCallback);
    expect(service.webLocationPermissions, webPermissionStatus);
    expect(service.platformService, mockPlatformService);
  });

  test("Create is correct for web without permissions", () async {
    LocationData initialLocation = getLocationData(1.0, 1.0);
    bool activeShareMode = true;
    bool shareLocationEnabled = true;
    changeLocationStateCallback(latlgn) => log('location changed');
    PermissionStatus webPermissionStatus = PermissionStatus.deniedForever;
    MockPlatformService mockPlatformService = MockPlatformService();

    when(mockPlatformService.isWeb).thenReturn(true);
    when(mockPlatformService.isMobile).thenReturn(false);
    when(mockPlatformService.isDesktop).thenReturn(false);

    ShareLocationServiceImpl service = ShareLocationServiceImpl.build(
        initialLocation,
        activeShareMode,
        shareLocationEnabled,
        changeLocationStateCallback,
        webPermissionStatus,
        loc: MockLocation());

    await Future.delayed(const Duration(seconds: 1));

    verifyNever(
        mockHttpProvider.sendPostRequest(APIContract.updateLocation, any));
    expect(service.currentLocation, initialLocation);
    expect(service.activeShareMode, activeShareMode);
    expect(service.shareLocationEnabled, shareLocationEnabled);
    expect(service.changeLocationStateCallback, changeLocationStateCallback);
    expect(service.webLocationPermissions, webPermissionStatus);
    expect(service.platformService, mockPlatformService);
  });

  test("Create is correct for mobile with shareLocationEnabled", () async {
    LocationData initialLocation = getLocationData(1.0, 1.0);
    bool activeShareMode = true;
    bool shareLocationEnabled = true;
    changeLocationStateCallback(latlgn) => log('location changed');
    PermissionStatus webPermissionStatus = PermissionStatus.deniedForever;
    MockPlatformService mockPlatformService = MockPlatformService();
    MockLocation mockLocation = MockLocation();
    MockStream<LocationData> mockStream = MockStream();

    when(mockPlatformService.isWeb).thenReturn(false);
    when(mockPlatformService.isMobile).thenReturn(true);
    when(mockPlatformService.isDesktop).thenReturn(false);

    when(mockLocation.enableBackgroundMode(enable: true))
        .thenAnswer((_) async => true);
    when(mockLocation.onLocationChanged).thenAnswer((_) => mockStream);
    when(mockStream.listen(any)).thenReturn(MockStreamSubscription());

    ShareLocationServiceImpl service = ShareLocationServiceImpl.build(
        initialLocation,
        activeShareMode,
        shareLocationEnabled,
        changeLocationStateCallback,
        webPermissionStatus,
        loc: mockLocation);

    await Future.delayed(const Duration(seconds: 1));

    verify(mockHttpProvider.sendPostRequest(APIContract.updateLocation, any))
        .called(1);
    verify(mockLocation.enableBackgroundMode(enable: true)).called(1);
    verify(mockLocation.onLocationChanged).called(1);
    verify(mockStream.listen(any)).called(1);
    expect(service.currentLocation, initialLocation);
    expect(service.activeShareMode, activeShareMode);
    expect(service.shareLocationEnabled, shareLocationEnabled);
    expect(service.changeLocationStateCallback, changeLocationStateCallback);
    expect(service.webLocationPermissions, webPermissionStatus);
    expect(service.platformService, mockPlatformService);
  });
}

Response exampleGoogleMapsResponse() {
  return Response(
      jsonEncode(AddressResponse([
        Address([
          AddressComponent("", "", [""])
        ], "")
      ]).toJson()),
      200);
}

LocationData getLocationData(double lat, double lon) {
  return LocationData.fromMap({'latitude': lat, 'longitude': lon});
}
