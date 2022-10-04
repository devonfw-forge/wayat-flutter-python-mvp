import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/services/share_location/share_location_service.dart';
import 'package:wayat/services/share_location/share_location_service_factory.dart';

part 'share_location_state.g.dart';

// ignore: library_private_types_in_public_api
class ShareLocationState = _ShareLocationState with _$ShareLocationState;

/// Controls and updates the user's location
abstract class _ShareLocationState with Store {
  /// Service to communicate the updates to the server
  late ShareLocationService shareLocationService;

  /// Stores the user's location
  @observable
  LatLng currentLocation = const LatLng(0, 0);

  /// This mode defines frecuency of location updates for the current user.
  ///
  /// `true` is [active] and `false` is passive.
  ///
  /// If there is no user with the app opened close enough to us, we will be
  /// [passive] and update our location less frecuently.
  ///
  /// If at least one of our friends is close enough and seeing us in the map,
  /// we will be [active] and will send more location updates.
  ///
  @observable
  bool activeShareMode = true;

  /// Whether the user is currently sending their location to the server
  @observable
  bool shareLocationEnabled = false;

  /// Callback that will be called when the service detects that it needs
  /// to update the user's location
  late Function(LatLng) onLocationChanged =
      (newLoc) => setCurrentLocation(newLoc);

  /// Creates the share location service and sets up the initial location state
  ///
  /// Sets the [shareLocationService] to update the user's location
  Future initialize(
      {ShareLocationServiceFactory? locationServiceFactory}) async {
    ShareLocationServiceFactory shareLocationServiceFactory =
        locationServiceFactory ?? ShareLocationServiceFactory();

    shareLocationEnabled =
      GetIt.I.get<SessionState>().currentUser!.shareLocationEnabled;
    
    shareLocationService = await shareLocationServiceFactory.create(
        activeShareMode: activeShareMode,
        shareLocationEnabled: shareLocationEnabled,
        onLocationChanged: onLocationChanged);

    LocationData currentLocationData =
        shareLocationService.getCurrentLocation();
    currentLocation =
        LatLng(currentLocationData.latitude!, currentLocationData.longitude!);
  }

  /// Updates the option to share location in the state and [shareLocationService]
  @action
  void setShareLocationEnabled(bool shareLocation) {
    shareLocationEnabled = shareLocation;
    shareLocationService.setShareLocationEnabled(shareLocation);
  }

  /// Updates current location
  @action
  void setCurrentLocation(LatLng newLocation) {
    currentLocation = newLocation;
  }

  /// Updates the share location mode.
  @action
  void setActiveShareMode(bool mode) {
    activeShareMode = mode;
    shareLocationService.setActiveShareMode(activeShareMode);
  }
}
