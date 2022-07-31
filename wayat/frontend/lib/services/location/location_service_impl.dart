import 'dart:math';
import 'package:wayat/domain/location/location.dart';
import 'location_service.dart';

class LocationServiceImpl extends LocationService {
  @override
  Location generateLocation() {
    return _randomCoordinates();
  }

  Location _randomCoordinates() {
    final random = Random();
    double nextDouble(num min, num max) =>
        min + random.nextDouble() * (max - min);

    Location randomLocation = Location(
        latitude: nextDouble(-90, 90), longitude: nextDouble(-180, 180));

    return randomLocation;
  }
}
