import 'package:wayat/domain/location/location.dart';

class LocationMock {
  static final List<Location> coordinates = [
    Location(city: 'Dnipro', latitude: 48.450001, longitude: 34.983334),
    Location(city: 'Barcelona', latitude: 41.390205, longitude: 2.154007),
    Location(city: 'Larnaka', latitude: 34.923096, longitude: 33.634045),
    Location(city: 'Villazon', latitude: -22.090887, longitude: -65.596832),
    Location(city: 'Shanghai', latitude: 31.224361, longitude: 121.469170),
    Location(city: 'Tallin', latitude: 59.436962, longitude: 24.753574),
    Location(city: 'Lyon', latitude: 45.763420, longitude: 4.834277),
    Location(city: 'Athens', latitude: 37.983810, longitude: 23.727539),
    Location(city: 'Dublin', latitude: 53.350140, longitude: -6.266155),
    Location(city: 'Oslo', latitude: 59.911491, longitude: 10.757933),
  ];

  static List<Location> getLocation() {
    return coordinates.toList();
  }
}
