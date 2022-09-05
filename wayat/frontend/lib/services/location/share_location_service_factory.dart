import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/services/location/share_location_service.dart';
import 'package:wayat/services/location/share_location_service_impl.dart';

/// Creates a Share Location Service
///
/// Its main purpose is to wrap the static method [ShareLocationServiceImpl.create]
/// to make the call mockable and therefore, the class that calls it, testable
class ShareLocationServiceFactory {
  Future<ShareLocationService> create(
      {required ShareLocationMode shareLocationMode,
      required bool shareLocationEnabled,
      required Function(LatLng) onLocationChanged}) async {
    return await ShareLocationServiceImpl.create(
        shareLocationMode, shareLocationEnabled, onLocationChanged);
  }
}
