import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/status/user_status_service_impl.dart';

part 'user_status_state.g.dart';

class UserStatusState = _UserStatusState
    with _$UserStatusState;

abstract class _UserStatusState with Store {
  UserStatusService userStatusService = UserStatusService();

  _UserStatusState() {
    userStatusService
      .setUpListener(
        onContactsRefUpdate: (contacts) => setContactList(contacts),
        onLocationModeUpdate: (locationMode) => setLocationMode(locationMode)
      );
  }

  @observable
  List<ContactLocation> contacts = [];

  @observable
  ShareLocationMode locationMode = ShareLocationMode.passive;

  @action
  void setContactList(List<ContactLocation> newContacts) {
    contacts = newContacts;
  }

  @action
  void setLocationMode(ShareLocationMode newMode) {
    locationMode = newMode;
    GetIt.I.get<LocationState>().shareLocationService.setShareLocationMode(newMode);
  }

  void fetchContacts() {}
}
