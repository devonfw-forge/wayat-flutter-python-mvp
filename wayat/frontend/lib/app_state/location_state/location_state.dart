import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/location/share_location_service.dart';
import 'package:wayat/services/location/share_location_service_factory.dart';

part 'location_state.g.dart';

// ignore: library_private_types_in_public_api
class LocationState = _LocationState with _$LocationState;

abstract class _LocationState with Store {
  late ShareLocationService shareLocationService;

  late UserStatusState userStatusState;

  @observable
  LatLng currentLocation = const LatLng(0, 0);

  @observable
  bool shareLocationEnabled =
      GetIt.I.get<SessionState>().currentUser!.shareLocationEnabled;

  final ShareLocationServiceFactory shareLocationServiceFactory;

  late Function(LatLng) onLocationChanged =
      (newLoc) => setCurrentLocation(newLoc);

  _LocationState({ShareLocationServiceFactory? shareLocationServiceFactory})
      : shareLocationServiceFactory =
            shareLocationServiceFactory ?? ShareLocationServiceFactory();

  Future initialize() async {
    userStatusState = GetIt.I.get<UserStatusState>();

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

  @action
  void setShareLocationEnabled(bool shareLocation) {
    shareLocationEnabled = shareLocation;
    shareLocationService.setShareLocationEnabled(shareLocation);
  }

  @action
  void setCurrentLocation(LatLng newLocation) {
    currentLocation = newLocation;
  }
}
