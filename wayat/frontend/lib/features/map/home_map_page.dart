import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/location/mock/contact_location_mock.dart';
import 'dart:ui' as ui;

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

  //Google map controller
  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  //current user location
  Location currentLocation = Location();

  //contacts markers
  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  List<ContactLocation> contacts = ContactLocationMock.contacts;

  BitmapDescriptor _markerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

  //Get current user location
  void _getLocation() async {
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
              zoom: 12)));
    });
  }

  Future<Uint8List> loadNetworkImage(path) async {
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completed.complete(info)));
    final imageInfo = await completed.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void _getContactsMarkers() {
    for (var contact in contacts) {
      _markers.add(Marker(
          markerId: MarkerId(contact.username.toString()),
          position: LatLng(contact.latitude, contact.longitude),
          icon: _markerIcon,
          infoWindow: InfoWindow(title: contact.username)));
    }
  }

  void _getContactsAvatar() async {
    for (var contact in contacts) {
      Uint8List image = await loadNetworkImage(contact.imageUrl);
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image.buffer.asUint8List(),
          targetHeight: 150,
          targetWidth: 150);
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _markerIcon = BitmapDescriptor.fromBytes(resizedImageMarker);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // _getLocation();
      _getContactsAvatar();
      _getContactsMarkers();
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
        zoomControlsEnabled: true,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        buildingsEnabled: true,
        cameraTargetBounds: CameraTargetBounds.unbounded,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        mapType: MapType.normal,
        markers: _markers,
        onMapCreated: _onMapCreated,
      )
    ]);
  }
}
