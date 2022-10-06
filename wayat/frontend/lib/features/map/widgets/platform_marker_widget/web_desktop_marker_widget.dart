import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';
import 'package:wayat/services/image_service/image_service.dart';

/// Flutter map marker widget
class WebDesktopMarker extends PlatformMarker<Marker> {
  final ImageService imageService;

  final Marker marker;

  WebDesktopMarker({
    required ContactLocation contactLocation,
    required void Function() onTap,
    ImageService? imageService
  }) : 
    imageService = imageService ?? ImageService(),
    marker = Marker(
      point: LatLng(
        contactLocation.latitude, contactLocation.longitude),
      builder: (context) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
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
  Marker get() {
    return marker;
  }
}