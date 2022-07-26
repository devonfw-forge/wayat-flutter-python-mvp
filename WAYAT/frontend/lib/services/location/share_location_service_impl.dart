import 'package:location/location.dart';
import 'package:wayat/services/location/no_location_service_exception.dart';
import 'package:wayat/services/location/rejected_location_exception.dart';
import 'package:wayat/services/location/share_location_service.dart';

/// This service will share the user's location with the BackEnd
/// when the conditions are met
class ShareLocationServiceImpl extends ShareLocationService {
  final int minDistance = 20;
  final int maxTimeMin = 15;

  late Location location;
  late PermissionStatus locationPermissions;
  late LocationData locationData;

  /// Creates a ShareLocationService.
  ///
  /// It can throw a RejectedLocationException if the user
  /// rejects location permissions
  ///
  /// It can throw A NoLocationServiceException if the call
  /// to Location.requestService() results in an error
  static Future<ShareLocationServiceImpl> create() async {
    Location location = Location();

    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
      if (!locationServiceEnabled) {
        throw NoLocationServiceException();
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted == PermissionStatus.denied) {
        throw RejectedLocationException();
      }
    }

    LocationData initialLocation = await location.getLocation();

    return ShareLocationServiceImpl._create(initialLocation);
  }

  /// Private factory for the location service
  ///
  /// It needs to be divided in private and public static factory to be able to
  /// make the necessary async calls in the public version
  ShareLocationServiceImpl._create(LocationData initialLocation)
      : super.create() {
    location = Location.instance;

    location.enableBackgroundMode(enable: true);

    location.onLocationChanged.listen((LocationData currentLocation) {
      sendLocationToBack(currentLocation);
    });
  }

  @override
  void sendLocationToBack(LocationData newLocation) {}
}
