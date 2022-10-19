import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';
// ignore: library_prefixes
import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMap;
import 'package:wayat/services/image_service/image_service.dart';

/// Google map marker widget
class MobileMarker extends PlatformMarker<GoogleMap.Marker> {
  final ImageService imageService;

  final GoogleMap.Marker marker;

  MobileMarker({
    required ContactLocation contactLocation,
    required void Function() onTap,
    required GoogleMap.BitmapDescriptor icon,
    ImageService? imageService
  }) : 
    imageService = imageService ?? ImageService(),
    marker = GoogleMap.Marker(
      markerId:
        GoogleMap.MarkerId("${contactLocation.id}¿?${contactLocation.name}¿?${contactLocation.longitude}${contactLocation.latitude}"),
      position: GoogleMap.LatLng(
        contactLocation.latitude, contactLocation.longitude),
      icon: icon,
      onTap: onTap
    ), super(
      contactLocation: contactLocation,
      onTap: onTap
    );
  
  @override
  GoogleMap.Marker get() {
    return marker;
  }
}