// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// ignore: library_prefixes
import 'package:google_maps_flutter/google_maps_flutter.dart' as FlutterGMap;
// ignore: depend_on_referenced_packages, library_prefixes
import 'package:google_maps/google_maps.dart' as WebGMap;
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'dart:ui' as ui;
import 'package:wayat/features/map/controller/map_controller.dart';


/// Web google maps widget
class MapWidget extends StatelessWidget {
  final Set<FlutterGMap.Marker> markers;
  final MapController controller;

  const MapWidget({
    required this.markers, 
    required this.controller, 
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      String htmlId = "gmap${markers.hashCode}";
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
        LocationState locationState = GetIt.I.get<LocationState>();
        WebGMap.LatLng currentLocation = WebGMap.LatLng(locationState.currentLocation.latitude,
            locationState.currentLocation.longitude);
        if (currentLocation.lat != 0 && currentLocation.lng != 0) {}
        final mapOptions = WebGMap.MapOptions()
          ..zoom = (
            // If the location permissions are not accepted, 
            // the latitude and longitude will be 0, 
            // in which case the zoom is considerably decreased
            (currentLocation.lat != 0 && currentLocation.lng != 0) ?
            15 : 3
          )
          ..center = currentLocation;
        DivElement elem = DivElement()
          ..id = htmlId
          ..style.width = "100%"
          ..style.height = "100%"
          ..style.border = 'none';
        WebGMap.GMap map = WebGMap.GMap(elem, mapOptions);
        for (ContactLocation contact in GetIt.I.get<UserStatusState>().contacts) {
          WebGMap.Icon icon = WebGMap.Icon()
            ..url=contact.imageUrl.toString()
            ..scaledSize=WebGMap.Size(40,40);
          WebGMap.Marker(WebGMap.MarkerOptions()
            ..position = WebGMap.LatLng(contact.latitude, contact.longitude)
            ..map = map
            ..icon = icon
            ..title = contact.name
          );
          final areaCircle = WebGMap.CircleOptions()
            ..map = map
            ..center = currentLocation
            ..fillColor = 'blue'
            ..strokeColor = 'blue'
            ..radius = 30;
          WebGMap.Circle(areaCircle);
        }
        return elem;
      });

      return HtmlElementView(viewType: htmlId);
  }
}
