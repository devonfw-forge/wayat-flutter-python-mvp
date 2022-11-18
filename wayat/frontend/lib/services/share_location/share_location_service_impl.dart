import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/ip_location/ip_location_service.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/share_location/background_location_exception.dart';
import 'package:wayat/services/share_location/last_web_location.dart';
import 'package:wayat/services/share_location/no_location_service_exception.dart';
import 'package:wayat/services/share_location/rejected_location_exception.dart';
import 'package:wayat/services/share_location/share_location_service.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:wayat/services/google_maps_service/google_maps_service.dart';

/// This service will share the user's location with the BackEnd
/// when the conditions are met
class ShareLocationServiceImpl extends ShareLocationService {
  @visibleForTesting
  ShareLocationServiceImpl() : super.create();

  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();
  static IPLocationService ipLocationService = GetIt.I.get<IPLocationService>();

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

  @visibleForTesting
  static Future<void> checkLocationPermissions({Location? loc}) async {
    Location location = loc ?? Location();

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
  /// Throws a [RejectedLocationException] if the user
  /// rejects location permissions. Throws a [NoLocationServiceException]
  /// if the call to ```Location.requestService()``` results in an error
  static Future<ShareLocationServiceImpl> create(
      bool mode, bool shareLocation, Function(LatLng) onLocationChangedCallback,
      [PlatformService? platformService]) async {
    platformService ??= PlatformService();
    Location location = Location();
    PermissionStatus? webPermissionStatus;
    LocationData? initialLocation;

    if (platformService.isWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool validCache = false;
      LastWebLocation? webLocationCache;

      String? lastWebLocationJson = prefs.getString("last_web_location");
      if (lastWebLocationJson != null) {
        webLocationCache = LastWebLocation.fromJson(lastWebLocationJson);
        if (DateTime.now()
                .difference(webLocationCache.updatedDateTime)
                .inMinutes <
            30) {
          validCache = true;
        }
      }

      if (!validCache) {
        webPermissionStatus = await location.requestPermission();
        if (webPermissionStatus != PermissionStatus.deniedForever) {
          initialLocation = await location.getLocation();
          prefs.setString(
              "last_web_location",
              LastWebLocation(
                      lastLocation: initialLocation,
                      updatedDateTime: DateTime.now())
                  .toJson());
        } else {
          initialLocation = LocationData.fromMap(
              {"latitude": 48.864716, "longitude": 2.349014});
        }
      } else {
        initialLocation = webLocationCache!.lastLocation;
        webPermissionStatus = PermissionStatus.granted;
      }
    } else {
      await checkLocationPermissions();
      initialLocation = await location.getLocation();
    }

    if (platformService.isDesktop) {
      initialLocation = await ipLocationService.getLocationData();
      print("Get desktop initial ip location = $initialLocation");
    }

    return ShareLocationServiceImpl.build(initialLocation, mode, shareLocation,
        onLocationChangedCallback, webPermissionStatus,
        platformService: platformService);
  }

  /// Private factory for the location service
  ///
  /// It needs to be divided in private and public static factory to be able to
  /// make the necessary async calls in the public version
  @visibleForTesting
  ShareLocationServiceImpl.build(
      LocationData initialLocation,
      bool mode,
      bool shareLocation,
      Function(LatLng) onLocationChangedCallback,
      PermissionStatus? webPermissionStatus,
      {PlatformService? platformService,
      Location? loc})
      : super.create() {
    this.platformService = platformService ?? PlatformService();

    location = loc ?? Location.instance;
    activeShareMode = mode;
    lastShared = DateTime.now();
    currentLocation = initialLocation;
    shareLocationEnabled = shareLocation;
    changeLocationStateCallback = onLocationChangedCallback;
    webLocationPermissions = webPermissionStatus;

    // If we are not in web with denegated location permissions
    if (!(this.platformService.isWeb &&
            webPermissionStatus == PermissionStatus.deniedForever) &&
        shareLocationEnabled) {
      sendLocationToBack(initialLocation);
    }

    if (this.platformService.isDesktop) {
      sendLocationToBack(initialLocation);
      print(
          "Sent desktop ip location to backend initialLocation = $initialLocation");
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
  Future<void> manageLocationChange(LocationData newLocation) async {
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
    await sendLocationToBack(newLocation);
  }

  @override
  Future<void> sendLocationToBack(LocationData locationData) async {
    LatLng location = LatLng(locationData.latitude!, locationData.longitude!);
    changeLocationStateCallback(location);
    String address = await GoogleMapsService.getAddressFromCoordinates(location,
        httpClient: httpProvider.client);
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
  Future<void> setActiveShareMode(bool activeShareMode) async {
    if (activeShareMode && shareLocationEnabled && !platformService.isWeb) {
      await sendForcedLocationUpdate();
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
  Future<void> sendForcedLocationUpdate() async {
    if (platformService.isDesktop) {
      currentLocation = await ipLocationService.getLocationData();
      print(
          "Send force location update to backend currentLocation = $currentLocation");
    } else {
      currentLocation = await location.getLocation();
    }
    await sendLocationToBack(currentLocation);
  }

  @override
  Future<void> setShareLocationEnabled(bool shareLocation) async {
    shareLocationEnabled = shareLocation;

    await httpProvider.sendPostRequest(
        APIContract.preferences, {"share_location": shareLocation});

    if (shareLocation) {
      await sendForcedLocationUpdate();
    }
  }

  /// Distance will returned in ```meters```
  double calculateDistance(LocationData newLocation) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((newLocation.latitude! - currentLocation.latitude!) * p) / 2 +
        cos(newLocation.latitude! * p) *
            cos(currentLocation.latitude! * p) *
            (1 -
                cos((newLocation.longitude! - currentLocation.longitude!) *
                    p)) /
            2;
    return 12742 * asin(sqrt(a)) * 1000;
  }
}
