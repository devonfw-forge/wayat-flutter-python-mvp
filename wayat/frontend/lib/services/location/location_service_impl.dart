import 'dart:math';
import 'package:wayat/domain/location/location.dart';
import 'location_service.dart';

class LocationServiceImpl extends LocationService {
  @override
  Location generateLocation() {
    Location currentLocation =
        Location(latitude: 39.477036267329765, longitude: -0.3861790889338262);
    int radius = 50;

    return _getRandomLocationNearBy(currentLocation, radius);
    //return _getRandomLocationInTheWorld();
  }

//Random coordinates (lat and lng) all over the World
  Location _getRandomLocationInTheWorld() {
    final random = Random();
    double nextDouble(num min, num max) =>
        min + random.nextDouble() * (max - min);

    Location randomLocation = Location(
        latitude: nextDouble(-90, 90), longitude: nextDouble(-180, 180));

    return randomLocation;
  }

//Random coordinates nearby choosen location
  Location _getRandomLocationNearBy(Location point, int radius) {
    double x0 = point.latitude;
    double y0 = point.longitude;

    Random random = Random();

    // Convert radius from meters to degrees
    double radiusInDegrees = radius / 111000;

    double u = random.nextDouble();
    double v = random.nextDouble();
    double w = radiusInDegrees * sqrt(u);
    double t = 2 * pi * v;
    double x = w * cos(t);
    double y = w * sin(t) * 1.75;

    // Adjust the x-coordinate for the shrinking of the east-west distances
    double newX = x / sin(y0);

    double foundLatitude = newX + x0;
    double foundLongitude = y + y0;
    Location randomLatLng =
        Location(latitude: foundLatitude, longitude: foundLongitude);

    return randomLatLng;
  }
}
