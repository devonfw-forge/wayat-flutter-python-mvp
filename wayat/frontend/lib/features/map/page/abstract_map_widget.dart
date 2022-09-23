
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/map/page/map_mobile_widget.dart' if (dart.library.html) 'package:wayat/features/map/page/map_web_widget.dart';

Widget getMapWidget(Set<Marker> markers, MapController controller) {
  return getMap(markers, controller);
}
