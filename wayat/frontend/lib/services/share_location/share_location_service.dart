import 'package:location/location.dart';

/// Service that manages the user's current location and
/// sends it to the server when the proper conditions and
/// permissions are met.
abstract class ShareLocationService {
  /// Creates a [ShareLocationService]
  ///
  /// It needs to be defined as a separate factory because it asks for permissions
  /// before being created, and this is an async process.
  ShareLocationService.create();

  /// Sends the user's location to the server
  void sendLocationToBack(LocationData locationData);

  /// Returns the current location of the user
  LocationData getCurrentLocation();

  /// Sets the mode ACTIVE or PASSIVE
  /// If we become ACTIVE, update the location automatically
  void setActiveShareMode(bool activeShareMode);

  /// Sets sharing the location TRUE or FALSE
  /// If start sharing the location, update it
  void setShareLocationEnabled(bool shareLocation);

  /// Whether the user has given permissions to get the location in web
  bool isWebLocationEnabled();
}
