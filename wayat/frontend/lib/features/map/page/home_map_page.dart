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
    return Stack(
      children: [
        Observer(builder: (context) {
          Set<Marker> markers = controller.markers;
          return GoogleMap(
            initialCameraPosition: _valencia,
            zoomControlsEnabled: true,
            tiltGesturesEnabled: false,
            myLocationEnabled: false,
            zoomGesturesEnabled: true,
            buildingsEnabled: true,
            cameraTargetBounds: CameraTargetBounds.unbounded,
            scrollGesturesEnabled: false,
            rotateGesturesEnabled: false,
            mapType: MapType.normal,
            markers: markers,
            onMapCreated: (_) => controller.getMarkers(),
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
