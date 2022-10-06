
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/features/map/controller/map_controller.dart';

/// Google and Flutter map parent widget
abstract class PlatformMapWidget extends StatelessWidget {
  final Set<Marker> markers;
  final MapController controller;

  const PlatformMapWidget({
    required this.markers, 
    required this.controller, 
    Key? key}) : super(key: key);
}