import 'dart:math';
import 'package:wayat/domain/location/contact_location.dart';
import 'location_service.dart';

class LocationServiceImpl extends LocationService {
  @override
  ContactLocation getContactLocation(ContactLocation currentLocation) {
    Random random = Random();
    double moveMeters = random.nextDouble() * 10; //increments 0..10 meters move

    ContactLocation newLocation = currentLocation;
    newLocation.latitude = currentLocation.latitude + moveMeters;
    newLocation.longitude = currentLocation.longitude + moveMeters;

    return newLocation;
  }
}
