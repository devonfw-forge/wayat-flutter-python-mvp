import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/lang/app_localizations.dart';

class HomeMapPage extends StatelessWidget {
  final MapController controller = MapController();

  HomeMapPage({Key? key}) : super(key: key);

  static const CameraPosition _valencia = CameraPosition(
    target: LatLng(39.4702, -0.376805),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    controller.getMarkers();

    return Stack(
      children: [
        Observer(builder: (context) {
          return GoogleMap(
            initialCameraPosition: _valencia,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            buildingsEnabled: true,
            cameraTargetBounds: CameraTargetBounds.unbounded,
            scrollGesturesEnabled: false,
            rotateGesturesEnabled: false,
            mapType: MapType.normal,
            markers: controller.markers,
          );
        }),
        _bottomSheet()
      ],
    );
  }

  DraggableScrollableSheet _bottomSheet() {
    return DraggableScrollableSheet(
        minChildSize: 0.13,
        initialChildSize: 0.13,
        //TODO: REMOVE THIS PROPERTY WHEN CONTACT LIST IS IMPLEMENTED
        maxChildSize: 0.13,
        builder: (context, scrollController) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: _bottomSheetScrollView(scrollController),
            ));
  }

  Widget _bottomSheetScrollView(ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _scrollIndicator(),
            const SizedBox(
              height: 15,
            ),
            _sharingLocationButton()
          ],
        ),
      ),
    );
  }

  Container _scrollIndicator() {
    return Container(
      height: 5,
      width: 60,
      decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(40))),
    );
  }

  Row _sharingLocationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.sharingLocation,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 18),
        ),
        Observer(builder: (context) {
          return CustomSwitch(
            value: controller.sharingLocation,
            onChanged: (newValue) {
              controller.setSharingLocation(newValue);
            },
          );
        })
      ],
    );
  }
}

/*
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/location/mock/contact_location_mock.dart';
import 'dart:ui' as ui;
import 'contact_circle_avatar.dart';

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
 */
