import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/features/map/controller/platform_map_controller/platform_map_controller.dart';

/// Concrete implementation of [PlatformMapController] for Google maps using [GoogleMapController]
class MobileMapController extends PlatformMapController<GoogleMapController> {
  final GoogleMapController googleMapController;

  MobileMapController(this.googleMapController);

  @override
  void move(double latitude, double longitude) {
    googleMapController
        .moveCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));
  }
}
