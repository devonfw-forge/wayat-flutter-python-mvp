import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/services/location/share_location_service.dart';
import 'package:wayat/services/location/share_location_service_factory.dart';

part 'location_state.g.dart';

// ignore: library_private_types_in_public_api
class LocationState = _LocationState with _$LocationState;

/// Controls and updates the user's location
abstract class _LocationState with Store {
  /// Service to communicate the updates to the server
  late ShareLocationService shareLocationService;

  /// Stores the user's location
  @observable
  LatLng currentLocation = const LatLng(0, 0);

  /// Whether the user is currently sending their location to the server
  @observable
  bool shareLocationEnabled =
      GetIt.I.get<SessionState>().currentUser!.shareLocationEnabled;

  /// Callback that will be called when the service detects that it needs
  /// to update the user's location
  late Function(LatLng) onLocationChanged =
      (newLoc) => setCurrentLocation(newLoc);

  /// Creates the share location service and sets up the initial location state
  ///
  /// Sets the [shareLocationService] to update the user's location, as well as initialize
  /// the Firebase listener in the UserStatusState
  Future initialize(
      {ShareLocationServiceFactory? locationServiceFactory}) async {
    ShareLocationServiceFactory shareLocationServiceFactory =
        locationServiceFactory ?? ShareLocationServiceFactory();
    UserStatusState userStatusState = GetIt.I.get<UserStatusState>();

    shareLocationService = await shareLocationServiceFactory.create(
        shareLocationMode: userStatusState.locationMode,
        shareLocationEnabled: shareLocationEnabled,
        onLocationChanged: onLocationChanged);

    await userStatusState.initializeListener();

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
}
