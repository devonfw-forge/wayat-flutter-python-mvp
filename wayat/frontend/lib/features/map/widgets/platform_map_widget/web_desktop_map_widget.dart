import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/features/map/controller/platform_map_controller/web_desktop_map_controller.dart';
import 'package:wayat/features/map/widgets/platform_map_widget/platform_map_widget.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Web and desktop flutter maps widget
class WebDesktopMapWidget extends PlatformMapWidget {
  final ShareLocationState shareLocationState =
      GetIt.I.get<LocationListener>().shareLocationState;
  final PlatformService platformService = GetIt.I.get<PlatformService>();

  WebDesktopMapWidget({required markers, required controller, Key? key})
      : super(markers: markers, controller: controller, key: key);

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    controller.platformMapController = WebDesktopMapController(mapController);
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          center: LatLng(shareLocationState.currentLocation.latitude,
              shareLocationState.currentLocation.longitude),
          zoom: 14.5),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.capgemini.wayat',
        ),
        MarkerLayer(
          markers: _generateMarkers(shareLocationState.currentLocation.latitude,
              shareLocationState.currentLocation.longitude),
        )
      ],
    );
  }

  List<Marker> _generateMarkers(latitude, longitude) {
    List<Marker> newMarkers = markers.map((e) => e.get() as Marker).toList();

    if (platformService.isDesktop ||
        (platformService.isWeb && shareLocationState.hasWebPermissions)) {
      newMarkers.add(Marker(
        point: LatLng(latitude, longitude),
        builder: (context) {
          return const Icon(
            Icons.circle,
            color: Color.fromARGB(159, 29, 158, 250),
          );
        },
      ));
    }
    return newMarkers;
  }
}
