import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/controller/map_controller_lib/web_desktop_map_controller.dart';
import 'package:wayat/features/map/page/map_page_lib/platform_map_widget.dart';

/// Web and desktop flutter maps widget
class WebDesktopMapWidget extends PlatformMapWidget {
  final ShareLocationState locationState =
      GetIt.I.get<LocationListener>().shareLocationState;

  WebDesktopMapWidget({required markers, required controller, Key? key})
      : super(markers: markers, controller: controller, key: key);

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    controller.platformMapController = WebDesktopMapController(mapController);
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          center: LatLng(locationState.currentLocation.latitude,
              locationState.currentLocation.longitude),
          zoom: 14.5),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.capgemini2.wayat',
        ),
        MarkerLayer(
          markers: _generateMarkers(),
        )
      ],
    );
  }

  List<Marker> _generateMarkers() {
    List<Marker> newMarkers = [];
    newMarkers.add(Marker(
      point: LatLng(locationState.currentLocation.latitude,
          locationState.currentLocation.longitude),
      builder: (context) {
        return const Icon(
          Icons.circle,
          color: Color.fromARGB(159, 29, 158, 250),
        );
      },
    ));
    for (ContactLocation contact
        in GetIt.I.get<LocationListener>().receiveLocationState.contacts) {
      newMarkers.add(Marker(
        width: 45,
        height: 45,
        point: LatLng(contact.latitude, contact.longitude),
        builder: (context) {
          return Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: Image.network(contact.imageUrl).image)));
        },
      ));
    }
    return newMarkers;
  }
}
