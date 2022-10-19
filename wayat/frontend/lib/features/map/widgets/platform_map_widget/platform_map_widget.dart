
import 'package:flutter/material.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';

/// Google and Flutter map parent widget
abstract class PlatformMapWidget extends StatelessWidget {
  final Set<PlatformMarker> markers;
  final MapController controller;

  const PlatformMapWidget({
    required this.markers, 
    required this.controller, 
    Key? key}) : super(key: key);
}