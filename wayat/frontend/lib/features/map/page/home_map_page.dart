import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/contacts_location/contacts_location_state.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/map/widgets/contact_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';

class HomeMapPage extends StatelessWidget {
  final LocationState locationState = GetIt.I.get<LocationState>();
  ContactsLocationState contactsLocationState =
      GetIt.I.get<ContactsLocationState>();
  late MapController controller;
  late GoogleMapController gMapController;

  HomeMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = MapController(
        onMarkerPressed: (contact, icon) =>
            showContactDialog(contact, icon, context));

    return Stack(
      children: [
        Observer(builder: (context) {
          List<ContactLocation> contacts = contactsLocationState.contacts;
          if (contacts != controller.contacts) {
            controller.setContacts(contacts);
            controller.getMarkers();
          }
          Set<Marker> markers = controller.markers;
          LatLng currentLocation = LatLng(
              locationState.currentLocation.latitude,
              locationState.currentLocation.longitude);
          return googleMap(markers, currentLocation);
        }),
        _bottomSheet()
      ],
    );
  }

  GoogleMap googleMap(Set<Marker> markers, LatLng currentLocation) {
    return GoogleMap(
        initialCameraPosition:
            CameraPosition(target: currentLocation, zoom: 14.5),
        zoomControlsEnabled: false,
        tiltGesturesEnabled: false,
        myLocationEnabled: false,
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
