import 'package:location/location.dart';

abstract class ShareLocationService {
  ShareLocationService.create();

  void sendLocationToBack(LocationData locationData);
}
