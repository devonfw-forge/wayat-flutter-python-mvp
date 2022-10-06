import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wayat/features/map/controller/map_controller_lib/platform_map_controller.dart';

class WebDesktopMapController extends PlatformMapController {
  late MapController flutterMapController;

  @override
  void updateController(dynamic controller) {
    flutterMapController = controller;
  }

  @override
  void move(double latitude, double longitude) {
    flutterMapController.move(
      LatLng(
        latitude, 
        longitude
      ), 15
    );
  }
}