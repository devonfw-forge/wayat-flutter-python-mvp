import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wayat/domain/location/contact_location.dart';

class HomeMapPage extends StatefulWidget {
  const HomeMapPage({Key? key}) : super(key: key);

  @override
  State<HomeMapPage> createState() => HomeMapPageState();
}

class HomeMapPageState extends State<HomeMapPage> {
  static const CameraPosition _valencia = CameraPosition(
    target: LatLng(39.4702, -0.376805),
    zoom: 19,
  );

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  Location currentLocation = Location();

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  void _addMarkers(List<ContactLocation> contacts) {
    for (var contact in contacts) {
      _markers.add(Marker(
          markerId: MarkerId(contact.username.toString()),
          position: LatLng(contact.latitude, contact.longitude)));
    }
  }

  void getLocation() async {
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
              zoom: 15)));
      setState(() {
        _markers.add(Marker(
            markerId: const MarkerId('CurrentContactLocation'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        initialCameraPosition: _valencia,
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        mapType: MapType.hybrid,
        markers: _markers,
      )
    ]);
  }
}
