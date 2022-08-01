import 'dart:math';
import 'package:wayat/domain/location/contact_location.dart';
import 'location_service.dart';

class LocationServiceImpl extends LocationService {
  @override
  ContactLocation getContactLocation(ContactLocation currentLocation) {
    ContactLocation newLocation = currentLocation;
    Random random = Random();
    double moveMeters = random.nextDouble() * 10; //increments 0..10 meters move

    double earth = 6378.137; //radius of the earth in kilometer
    double m = (1 / ((2 * pi / 360) * earth)) / 1000; //1 meter in degree

    //For latitude coordinates
    newLocation.latitude = currentLocation.latitude + (moveMeters * m);
    //For longtitude coordinates
    newLocation.longitude = currentLocation.longitude +
        (moveMeters * m) / cos(currentLocation.longitude * (pi / 180));

    return newLocation;
  }
}
