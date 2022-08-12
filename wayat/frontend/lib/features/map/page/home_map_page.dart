import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/map/widgets/contact_dialog.dart';
import 'package:wayat/features/map/widgets/contact_map_list_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/location/mock/contact_location_mock.dart';

class HomeMapPage extends StatelessWidget {
  final LocationState locationState = GetIt.I.get<LocationState>();
  final UserStatusState userStatusState = GetIt.I.get<UserStatusState>();
  late MapController controller;
  late GoogleMapController gMapController;

  HomeMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = MapController(
        onMarkerPressed: (contact, icon) =>
            showContactDialog(contact, icon, context));

    return FutureBuilder(
        future: locationState.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Observer(builder: (context) {
                  List<ContactLocation> contacts = userStatusState.contacts;
                  if (contacts != controller.contacts) {
                    controller.setContacts(contacts);
                    controller.getMarkers();
                  }
                  Set<Marker> markers = controller.markers;
                  return googleMap(markers);
                }),
                _bottomSheet()
              ],
            );
          } else {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  GoogleMap googleMap(Set<Marker> markers) {
    LatLng currentLocation = LatLng(locationState.currentLocation.latitude,
        locationState.currentLocation.longitude);

    return GoogleMap(
        initialCameraPosition:
            CameraPosition(target: currentLocation, zoom: 14.5),
        zoomControlsEnabled: false,
        tiltGesturesEnabled: false,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        buildingsEnabled: true,
        cameraTargetBounds: CameraTargetBounds.unbounded,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        mapType: MapType.normal,
        markers: markers,
        onLongPress: (_) => controller.markers,
        onMapCreated: (googleMapController) {
          gMapController = googleMapController;
          Location location = Location();
          location.onLocationChanged.listen((l) async {
            try {
              await gMapController.moveCamera(
                  CameraUpdate.newLatLng(LatLng(l.latitude!, l.longitude!)));
            } catch (e) {
              log("Exception: Map not created");
            }
          });
          controller.markers;
        },
        onCameraMove: (pos) => {
              if (pos.target != currentLocation)
                {
                  gMapController
                      .moveCamera(CameraUpdate.newLatLng(currentLocation))
                }
            });
  }

  DraggableScrollableSheet _bottomSheet() {
    return DraggableScrollableSheet(
        minChildSize: 0.13,
        initialChildSize: 0.13,
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
            _sharingLocationButton(),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            mapListView()
          ],
        ),
      ),
    );
  }

  Widget mapListView() {
    return Observer(builder: (context) {
      List<ContactLocation> contacts = userStatusState.contacts;
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              ContactMapListTile(contact: contacts[index]),
          separatorBuilder: (_, __) => const Divider(
                color: Colors.black26,
              ),
          itemCount: contacts.length);
    });
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
            value: locationState.shareLocationEnabled,
            onChanged: (newValue) {
              locationState.setShareLocationEnabled(newValue);
            },
          );
        })
      ],
    );
  }

  void showContactDialog(
      ContactLocation contact, BitmapDescriptor icon, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ContactDialog(
            contact: contact,
            icon: icon,
          );
        });
  }
}
