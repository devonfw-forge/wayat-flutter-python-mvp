import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/features/map/controller/map_controller_lib/platform_map_controller.dart';

class MobileMapController extends PlatformMapController {
  late GoogleMapController googleMapController;

  @override
  void updateController(dynamic controller) {
    googleMapController = controller;
  }
  
  @override
  void move(double latitude, double longitude) {
    googleMapController.moveCamera(
      CameraUpdate.newLatLng(
        LatLng(
          latitude, 
          longitude
        )
      )
    );
  }
}