import 'package:wayat/domain/location/contact_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationService {
  List<ContactLocation> getAll();

  LatLng changeContactCoordinates(LatLng currentLocation);
}
