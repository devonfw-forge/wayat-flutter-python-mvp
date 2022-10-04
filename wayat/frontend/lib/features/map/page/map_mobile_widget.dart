import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/features/map/controller/map_controller.dart';


/// Android and IOS google maps widget
class MapWidget extends StatelessWidget {
  final Set<Marker> markers;
  final MapController controller;

  const MapWidget({
    required this.markers, 
    required this.controller, 
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShareLocationState shareLocationState = GetIt.I.get<LocationListener>().shareLocationState;
    LatLng currentLocation = LatLng(shareLocationState.currentLocation.latitude,
      shareLocationState.currentLocation.longitude);
    return GoogleMap(
      onTap: (_) {
        removeFocusFromSearchBar(context);
      },
      initialCameraPosition:
          CameraPosition(target: currentLocation, zoom: 14.5),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      markers: markers,
      onMapCreated: (googleMapController) {
        controller.gMapController = googleMapController;
      },
    );
  }

  void removeFocusFromSearchBar(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}