import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/services/image_service/image_service.dart';

/// Google map marker widget
abstract class MobileMarker extends PlatformMarker<Marker> {
  final ImageService imageService;

  final Marker marker;

  MobileMarker({
    required ContactLocation contactLocation, 
    required double latitude, 
    required double longitude,
    required void Function() onTap,
    required BitmapDescriptor icon,
    ImageService? imageService
  }) : 
    imageService = imageService ?? ImageService(),
    marker = Marker(
      markerId:
        MarkerId("${contactLocation.id}¿?${contactLocation.name}¿?${contactLocation.longitude}${contactLocation.latitude}"),
      position: LatLng(latitude, longitude),
      icon: icon,
      onTap: onTap
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