import 'dart:math';

import 'package:wayat/domain/location/location.dart';
import 'package:wayat/services/location/location_service.dart';
import 'mock/location-mock.dart';

class LocationServiceImpl extends LocationService {
  @override
  List<Location> getAll() {
    return LocationMock.getLocation();
  }

  void RandomCoordinates() {
    final random = Random();
    double nextDouble(num min, num max) =>
        min + random.nextDouble() * (max - min);

    double randomLat = nextDouble(-90, 90);
    double randomLng = nextDouble(-180, 180);
    print('$randomLat, $randomLng');
  }
}
