import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/services/image_service/image_service.dart';

/// Google map marker widget
class MobileMarker extends PlatformMarker<Marker> {
  final ImageService imageService;

  final Marker marker;

  MobileMarker({
    required ContactLocation contactLocation,
    required void Function() onTap,
    required BitmapDescriptor icon,
    ImageService? imageService
  }) : 
    imageService = imageService ?? ImageService(),
    marker = Marker(
      markerId:
        MarkerId("${contactLocation.id}¿?${contactLocation.name}¿?${contactLocation.longitude}${contactLocation.latitude}"),
      position: LatLng(
        contactLocation.latitude, contactLocation.longitude),
      icon: icon,
      onTap: onTap
    ), super(
      contactLocation: contactLocation,
      onTap: onTap
    );
  
  @override
  Marker get() {
    return marker;
  }
}