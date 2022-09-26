import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/features/map/controller/map_controller.dart';

Widget getMap(Set<Marker> markers, MapController controller) {
  LocationState locationState = GetIt.I.get<LocationState>();
  LatLng currentLocation = LatLng(locationState.currentLocation.latitude,
      locationState.currentLocation.longitude);
  return GoogleMap(
    initialCameraPosition:
        CameraPosition(target: currentLocation, zoom: 14.5),
    myLocationEnabled: true,
    zoomControlsEnabled: false,
    markers: markers,
    mapType: MapType.normal,
    onMapCreated: (googleMapController) async {
      controller.gMapController = googleMapController;
    },
  );
}