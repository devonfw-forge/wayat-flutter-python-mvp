import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:flutter_map/flutter_map.dart' as FlutterMap;
// ignore: library_prefixes
import 'package:latlong2/latlong.dart' as LatLong;
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';
import 'package:wayat/services/image_service/image_service.dart';

/// Flutter map marker widget
class WebDesktopMarker extends PlatformMarker<FlutterMap.Marker> {
  final ImageService imageService;

  final FlutterMap.Marker marker;

  WebDesktopMarker({
    required ContactLocation contactLocation,
    required void Function() onTap,
    ImageService? imageService
  }) : 
    imageService = imageService ?? ImageService(),
    marker = FlutterMap.Marker(
      width: 45,
      height: 45,
      point: LatLong.LatLng(
        contactLocation.latitude, contactLocation.longitude),
      builder: (context) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: Image.network(contactLocation.imageUrl).image
              )
            )
          ),
        );
      },
    ), super(
      contactLocation: contactLocation,
      onTap: onTap
    );
  
  @override
  FlutterMap.Marker get() {
    return marker;
  }
}