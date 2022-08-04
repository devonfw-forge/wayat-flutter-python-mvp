import 'dart:math';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/location/mock/contact_location_mock.dart';

import 'location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationServiceImpl extends LocationService {
  @override
  List<ContactLocation> getAll() {
    return ContactLocationMock.contacts;
  }

  @override
  LatLng changeContactCoordinates(LatLng currentLocation) {
    Random random = Random();
    double moveMeters = random.nextDouble() * 10; //increments 0..10 meters move

    double earth = 6378.137; //radius of the earth in kilometer
    double m = (1 / ((2 * pi / 360) * earth)) / 1000; //1 meter in degree

    //For latitude coordinates
    double newLatitude = currentLocation.latitude + (moveMeters * m);
    //For longtitude coordinates
    double newLongitude = currentLocation.longitude +
        (moveMeters * m) / cos(currentLocation.longitude * (pi / 180));

    LatLng latLng = LatLng(newLatitude, newLongitude);
    return latLng;
  }
}
