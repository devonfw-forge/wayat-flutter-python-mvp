import 'package:mobx/mobx.dart';
import 'package:wayat/domain/location/contact_location.dart';

part 'receive_location_state.g.dart';

// ignore: library_private_types_in_public_api
class ReceiveLocationState = _ReceiveLocationState with _$ReceiveLocationState;

/// Manages receiving all of the contacts' current location
abstract class _ReceiveLocationState with Store {
  /// List of contacts currently sharing location with this user.
  @observable
  List<ContactLocation> contacts = [];

  /// Updates the contacts sharing location with us.
  @action
  void setContactList(List<ContactLocation> newContacts) {
    contacts = newContacts;
  }
}
