import 'package:location/location.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';

abstract class ShareLocationService {
  ShareLocationService.create();

  void sendLocationToBack(LocationData locationData);

  LocationData getCurrentLocation();

  /// Sets the mode ACTIVE or PASSIVE
  /// If we become ACTIVE, update the location
  void setShareLocationMode(ShareLocationMode shareLocationMode);

  /// Sets sharing the location TRUE or FALSE
  /// If start sharing the location, update it
  void setShareLocationEnabled(bool shareLocation);
}
