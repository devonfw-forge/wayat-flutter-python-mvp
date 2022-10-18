import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/share_location/background_location_exception.dart';
import 'package:wayat/services/share_location/no_location_service_exception.dart';
import 'package:wayat/services/share_location/rejected_location_exception.dart';
import 'package:wayat/services/share_location/share_location_service.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:wayat/services/google_maps_service/google_maps_service.dart';

/// This service will share the user's location with the BackEnd
/// when the conditions are met
class ShareLocationServiceImpl extends ShareLocationService {
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  /// 1 kilometer of distance
  final int passiveMinDistance = 1000;
  final Duration passiveMinTime = const Duration(minutes: 15);

  /// 50 meters of distance
  final int activeMinDistance = 50;
  final Duration activeMinTime = const Duration();

  late Location location;
  late PermissionStatus locationPermissions;
  late LocationData currentLocation;
  late bool activeShareMode;
  late DateTime lastShared;
  late bool shareLocationEnabled;
  late PermissionStatus? webLocationPermissions;
  late Function(LatLng) changeLocationStateCallback;
  late PlatformService platformService;

  static Future<void> _checkLocationPermissions() async {
    Location location = Location();

    // First, enable device location
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
      if (!locationServiceEnabled) {
        throw NoLocationServiceException();
      }
    }

    // Then, enable app location permission
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.denied ||
          permissionGranted == PermissionStatus.deniedForever) {
        throw RejectedLocationException();
      }
    }

    if (!await location.isBackgroundModeEnabled()) {
      try {
        await location.enableBackgroundMode(enable: true);
      } on PlatformException catch (e) {
        if (e.code == "PERMISSION_DENIED" ||
            e.code == "PERMISSION_DENIED_NEVER_ASK") {
          throw BackgroundLocationException();
        }
        log("${e.code}: ${e.message}");
        rethrow;
      }
    }
  }

  /// Creates a ShareLocationService.
  ///
  /// Throw a [RejectedLocationException] if the user
  /// rejects location permissions. Throws a [NoLocationServiceException]
  /// if the call to ```Location.requestService()``` results in an error
  static Future<ShareLocationServiceImpl> create(
      bool mode, bool shareLocation, Function(LatLng) onLocationChangedCallback,
      [PlatformService? platformService]) async {
    platformService ??= PlatformService();
    Location location = Location();
    PermissionStatus? webPermissionStatus;

    if (!platformService.isWeb) {
      await _checkLocationPermissions();
    } else {
      webPermissionStatus = await location.requestPermission();
    }
    LocationData? initialLocation;
    if (!(platformService.isWeb &&
        webPermissionStatus == PermissionStatus.deniedForever)) {
      initialLocation = await location.getLocation();
    } else {
      initialLocation =
          LocationData.fromMap({"latitude": 48.864716, "longitude": 2.349014});
    }

    return ShareLocationServiceImpl._create(
        initialLocation,
        mode,
        shareLocation,
        onLocationChangedCallback,
        webPermissionStatus,
        platformService);
  }

  /// Private factory for the location service
  ///
  /// It needs to be divided in private and public static factory to be able to
  /// make the necessary async calls in the public version
  ShareLocationServiceImpl._create(
      LocationData initialLocation,
      bool mode,
      bool shareLocation,
      Function(LatLng) onLocationChangedCallback,
      PermissionStatus? webPermissionStatus,
      [PlatformService? platformService])
      : super.create() {
    this.platformService = platformService ?? PlatformService();

    location = Location.instance;
    activeShareMode = mode;
    lastShared = DateTime.now();
    currentLocation = initialLocation;
    shareLocationEnabled = shareLocation;
    changeLocationStateCallback = onLocationChangedCallback;
    webLocationPermissions = webPermissionStatus;

    // If we are not in web with denegated location permissions
    if (!(this.platformService.isWeb &&
        webPermissionStatus != PermissionStatus.deniedForever)) {
      sendLocationToBack(initialLocation);
    }

    if (this.platformService.isMobile) {
      location.enableBackgroundMode(enable: true);

      location.onLocationChanged.listen((LocationData newLocation) {
        if (shareLocationEnabled) {
          manageLocationChange(newLocation);
        }
      });
    }
  }

  /// Checks all the conditions to send location to backend,
  /// including active and passive mode
  void manageLocationChange(LocationData newLocation) {
    double movedDistance = calculateDistance(newLocation);
    // Passive mode
    if (!activeShareMode) {
      DateTime now = DateTime.now();
      if (lastShared.difference(now).abs() < passiveMinTime &&
          movedDistance < passiveMinDistance) {
        return;
      }
    }
    // Active mode
    else if (movedDistance < activeMinDistance) {
      return;
    }

    lastShared = DateTime.now();
    currentLocation = newLocation;
    sendLocationToBack(newLocation);
  }

  @override
  Future<void> sendLocationToBack(LocationData locationData) async {
    LatLng location = LatLng(locationData.latitude!, locationData.longitude!);
    changeLocationStateCallback(location);
    String address =
        await GoogleMapsService.getAddressFromCoordinates(location);
    await httpProvider.sendPostRequest(APIContract.updateLocation, {
      "position": {
        "longitude": locationData.longitude,
        "latitude": locationData.latitude,
      },
      "address": address
    });
  }

  @override
  LocationData getCurrentLocation() {
    return currentLocation;
  }

  @override
  void setActiveShareMode(bool activeShareMode) {
    if (activeShareMode && shareLocationEnabled && !platformService.isWeb) {
      sendForcedLocationUpdate();
    }
    this.activeShareMode = activeShareMode;
  }

  @override
  bool isWebLocationEnabled() {
    return webLocationPermissions != null &&
        webLocationPermissions != PermissionStatus.denied &&
        webLocationPermissions != PermissionStatus.deniedForever;
  }

  /// Sends the current location to back without needing the conditions
  Future sendForcedLocationUpdate() async {
    currentLocation = await location.getLocation();
    sendLocationToBack(currentLocation);
  }

  @override
  void setShareLocationEnabled(bool shareLocation) {
    shareLocationEnabled = shareLocation;
    if (shareLocation) {
      shareLocationActivated();
    } else {
      httpProvider.sendPostRequest(
          APIContract.preferences, {"share_location": shareLocation});
    }
  }

  /// This method is necessary because we need to make sure that the POST to true
  /// is received BEFORE the location update. Otherwise it would be ignored
  Future shareLocationActivated() async {
    await httpProvider
        .sendPostRequest(APIContract.preferences, {"share_location": true});
    sendForcedLocationUpdate();
  }

  /// Distance will returned in ```meters```
  double calculateDistance(LocationData newLocation) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((newLocation.latitude! - currentLocation.latitude!) * p) / 2 +
        c(newLocation.latitude! * p) *
            c(currentLocation.latitude! * p) *
            (1 - c((newLocation.longitude! - currentLocation.longitude!) * p)) /
            2;
    return 12742 * asin(sqrt(a)) * 1000;
  }
}
