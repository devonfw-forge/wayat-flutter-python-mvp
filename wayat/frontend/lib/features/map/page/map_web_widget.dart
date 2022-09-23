// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// ignore: library_prefixes
import 'package:google_maps_flutter/google_maps_flutter.dart' as FlutterGMap;
// ignore: depend_on_referenced_packages, library_prefixes
import 'package:google_maps/google_maps.dart' as GMap;
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'dart:ui' as ui;

import 'package:wayat/features/map/controller/map_controller.dart';


Widget getMap(Set<FlutterGMap.Marker> markers, MapController controller) {
  String htmlId = "gmap${markers.hashCode}";
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    LocationState locationState = GetIt.I.get<LocationState>();
    GMap.LatLng currentLocation = GMap.LatLng(locationState.currentLocation.latitude,
        locationState.currentLocation.longitude);

    final mapOptions = GMap.MapOptions()
      ..zoom = 15
      ..center = currentLocation;

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = GMap.GMap(elem, mapOptions);
    
    for (ContactLocation contact in GetIt.I.get<UserStatusState>().contacts) {
      GMap.Icon icon = GMap.Icon()
        ..url=contact.imageUrl.toString()
        ..scaledSize=GMap.Size(40,40);
      GMap.Marker(GMap.MarkerOptions()
        ..position = GMap.LatLng(contact.latitude, contact.longitude)
        ..map = map
        ..icon = icon
        ..title = contact.name
      );
    }

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}