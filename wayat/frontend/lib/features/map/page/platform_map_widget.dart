
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/map/page/map_mobile_widget.dart' if (dart.library.html) 'package:wayat/features/map/page/map_web_widget.dart';

/// Google Maps Wrapper widget.
/// 
///  Classify the creation of the map widget between web or android and ios.
class PlatformMapWidget extends StatelessWidget {
  final Set<Marker> markers;
  final MapController controller;

  const PlatformMapWidget({
    required this.markers, 
    required this.controller, 
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MapWidget(markers: markers, controller: controller,);
  }
}