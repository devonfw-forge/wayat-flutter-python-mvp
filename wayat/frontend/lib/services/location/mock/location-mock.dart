import 'package:wayat/domain/location/location.dart';

class LocationMock {
  static final List<Location> coordinates = [
    //Dnipro
    Location(latitude: 48.450001, longitude: 34.983334),
    //Barcelona
    Location(latitude: 41.390205, longitude: 2.154007),
    //Larnaka
    Location(latitude: 34.923096, longitude: 33.634045),
    //Villazon
    Location(latitude: -22.090887, longitude: -65.596832),
    //Shanghai
    Location(latitude: 31.224361, longitude: 121.469170),
    //Tallin
    Location(latitude: 59.436962, longitude: 24.753574),
    //Lyon
    Location(latitude: 45.763420, longitude: 4.834277),
    //Athens
    Location(latitude: 37.983810, longitude: 23.727539),
    //Dublin
    Location(latitude: 53.350140, longitude: -6.266155),
    //Oslo
    Location(latitude: 59.911491, longitude: 10.757933),
  ];

  static List<Location> getLocation() {
    return coordinates.toList();
  }
}
