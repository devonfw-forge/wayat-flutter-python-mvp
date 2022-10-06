import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';
import 'package:wayat/services/image_service/image_service.dart';

/// Google map marker widget
abstract class WebDesktopMarker extends PlatformMarker<Marker> {
  final ImageService imageService;

  final Marker marker;

  WebDesktopMarker({
    required ContactLocation contactLocation, 
    required double latitude, 
    required double longitude,
    required void Function() onTap,
    required String imageUrl,
    ImageService? imageService
  }) : 
    imageService = imageService ?? ImageService(),
    marker = Marker(point: LatLng(latitude, longitude),
      builder: (context) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: Image.network(imageUrl).image
              )
            )
          ),
        );
      },
    ), super(
      contactLocation: contactLocation, 
      latitude: latitude, 
      longitude: longitude,
      onTap: onTap
    );
  
  @override
  Marker get() {
    return marker;
  }
}