import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wayat/features/map/controller/map_controller_lib/platform_map_controller.dart';

/// Concrete implementation of [PlatformMapController] for flutter maps using [MapController]
class WebDesktopMapController extends PlatformMapController<MapController> {
  final MapController flutterMapController;

  WebDesktopMapController(this.flutterMapController);

  @override
  void move(double latitude, double longitude) {
    flutterMapController.move(LatLng(latitude, longitude), 15);
  }
}
