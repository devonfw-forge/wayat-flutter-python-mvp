import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapPage extends StatefulWidget {
  @override
  State<HomeMapPage> createState() => HomeMapPageState();
}

class HomeMapPageState extends State<HomeMapPage> {
  static final CameraPosition _valencia = CameraPosition(
    target: LatLng(39.4702, -0.376805),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _valencia,
    );
  }
}
