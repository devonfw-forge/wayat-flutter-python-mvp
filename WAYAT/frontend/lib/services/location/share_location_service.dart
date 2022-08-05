import 'package:location/location.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';

abstract class ShareLocationService {
  ShareLocationService.create();

  void sendLocationToBack(LocationData locationData);

  LocationData getCurrentLocation();

  void setShareLocationMode(ShareLocationMode shareLocationMode);

  void setShareLocationEnabled(bool shareLocation);
}
