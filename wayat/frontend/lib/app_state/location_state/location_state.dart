import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/services/location/share_location_service.dart';
import 'package:wayat/services/location/share_location_service_impl.dart';

part 'location_state.g.dart';

class LocationState = _LocationState with _$LocationState;

abstract class _LocationState with Store {
  late ShareLocationService shareLocationService;

  late UserStatusState userStatusState;

  @observable
  LatLng currentLocation = const LatLng(0, 0);
  
  @observable
  bool shareLocationEnabled = true;

  Future initialize() async {
    userStatusState = GetIt.I.get<UserStatusState>();
    shareLocationService = await ShareLocationServiceImpl.create(
      userStatusState.locationMode,
      shareLocationEnabled, (newLoc) => setCurrentLocation(newLoc));
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
