import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationService extends Service {
  List<ContactLocation> getAll();
  LatLng changeContactCoordinates(LatLng currentLocation);
}
