import 'package:location/location.dart';

/// Communicates withan API to get [LocationData].
abstract class IPLocationService {
  /// Returns the location data [LocationData] from the current IP network 
  /// interface. If there is an issue with network or location could not be 
  /// fetch is uses a default location (Paris).
  Future<LocationData> getLocationData();
}