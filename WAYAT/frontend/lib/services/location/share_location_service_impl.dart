import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/services/location/no_location_service_exception.dart';
import 'package:wayat/services/location/rejected_location_exception.dart';
import 'package:wayat/services/location/share_location_service.dart';
import 'dart:math' show cos, sqrt, asin;

/// This service will share the user's location with the BackEnd
/// when the conditions are met
class ShareLocationServiceImpl extends ShareLocationService {
  final Duration passiveMinTime = const Duration(minutes: 15);
  /// 1 kilometer of distance 
  final int passiveMinDistance = 1000;
  final Duration activeMinTime = const Duration();
  /// 50 meters of distance
  final int activeMinDistance = 50;

  late Location location;
  late PermissionStatus locationPermissions;
  late LocationData currentLocation;
  late ShareLocationMode shareLocationMode;
  late DateTime lastShared;
  late bool shareLocationEnabled;
  late Function(LatLng) changeLocationStateCallback;


  /// Creates a ShareLocationService.
  ///
  /// Throw a [RejectedLocationException] if the user
  /// rejects location permissions. Throws a [NoLocationServiceException] 
  /// if the call to ```Location.requestService()``` results in an error
  static Future<ShareLocationServiceImpl> create(ShareLocationMode mode,
      bool shareLocation, Function(LatLng) onLocationChangedCallback) async {
    Location location = Location();

    // First, enable device location
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
      if (!locationServiceEnabled) {
        debugPrint("No location service enabled");
        throw NoLocationServiceException();
      }
    }

    // Then, enable app location permission
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      debugPrint("Requesting permission");
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.denied) {
        debugPrint("No permission");
        throw RejectedLocationException();
      }
    }

    debugPrint("Setting initial Location");
    LocationData initialLocation = await location.getLocation();
    debugPrint("initial location $initialLocation");

    debugPrint("Creating location service");
    return ShareLocationServiceImpl._create(
      initialLocation, mode, shareLocation, onLocationChangedCallback);
  }

  /// Private factory for the location service
  ///
  /// It needs to be divided in private and public static factory to be able to
  /// make the necessary async calls in the public version
  ShareLocationServiceImpl._create(
      LocationData initialLocation,
      ShareLocationMode mode,
      bool shareLocation,
      Function(LatLng) onLocationChangedCallback)
      : super.create() {
    location = Location.instance;
    shareLocationMode = mode;
    lastShared = DateTime.now();
    currentLocation = initialLocation;
    shareLocationEnabled = shareLocation;
    changeLocationStateCallback = onLocationChangedCallback;

    location.enableBackgroundMode(enable: true);

    location.onLocationChanged.listen((LocationData newLocation) {
      if (shareLocationEnabled) {
        manageLocationChange(newLocation);
      }
    });
  }

  /// Checks all the conditions to send location to backend,
  /// including active and passive mode
  void manageLocationChange(LocationData newLocation) {
    double movedDistance = calculateDistance(newLocation);
    debugPrint("----------------> MovedDistance: $movedDistance");
    // Passive mode
    if (shareLocationMode == ShareLocationMode.passive) {
      DateTime now = DateTime.now();
      debugPrint("------------------> Lastshared difference: ${lastShared.difference(now)}");

      if (lastShared.difference(now).abs() < passiveMinTime &&
          movedDistance < passiveMinDistance) {
        debugPrint("--------------------> Not sharing (Passive)");
        return;
      }
    } 
    // Active mode
    else if (movedDistance < activeMinDistance) {
      debugPrint("----------------> Not sharing (Active)");
      return;
    }
    debugPrint("----------------> Sharing");

    lastShared = DateTime.now();
    currentLocation = newLocation;
    sendLocationToBack(newLocation);
  }

  @override
  void sendLocationToBack(LocationData locationData) {
    changeLocationStateCallback(
        LatLng(locationData.latitude!, locationData.longitude!));
    super.sendPostRequest("/map/update-location", {
      "position": {
        "longitude": locationData.longitude,
        "latitude": locationData.latitude
      }
    });
  }

  @override
  LocationData getCurrentLocation() {
    return currentLocation;
  }

  @override
  void setShareLocationMode(ShareLocationMode shareLocationMode) {
    this.shareLocationMode = shareLocationMode;
  }

  @override
  void setShareLocationEnabled(bool shareLocation) {
    shareLocationEnabled = shareLocation;
  }

  double calculateDistance(LocationData newLocation) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((newLocation.latitude! - currentLocation.latitude!) * p) / 2 +
        c(newLocation.latitude! * p) *
            c(currentLocation.latitude! * p) *
            (1 - c((newLocation.longitude! - currentLocation.longitude!) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }
}
