import 'package:wayat/domain/location/contact_location.dart';

abstract class LocationListenerService {

  ///SetUp listener of contactLocation mode update from status
  Future<void> setUpListener(
      {required Function(List<ContactLocation>) onContactsRefUpdate,
      required Function(bool) onLocationModeUpdate});

  /// Closes current listener to Firestore
  void cancelListenerSubscription();
}
