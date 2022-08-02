import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/location/mock/contact_location_mock.dart';

class HomeMapPage extends StatefulWidget {
  const HomeMapPage({Key? key}) : super(key: key);

  @override
  State<HomeMapPage> createState() => HomeMapPageState();
}

class HomeMapPageState extends State<HomeMapPage> {
  static const CameraPosition _valencia = CameraPosition(
    target: LatLng(39.4702, -0.376805),
    zoom: 12,
  );

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;
  Location currentLocation = Location();
  List<Marker> markers = [];
  List<ContactLocation> contacts = ContactLocationMock.contacts;

  void getLocation() async {
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
              zoom: 12)));
    });
  }

  void getContactsMarkers() {
    for (var contact in contacts) {
      markers.add(Marker(
          markerId: MarkerId(contact.username.toString()),
          position: LatLng(contact.latitude, contact.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: contact.username)));
    }
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
      getContactsMarkers();
      _mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        initialCameraPosition: _valencia,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: Set<Marker>.of(markers),
        onMapCreated: _onMapCreated,
      )
    ]);
  }
}
