import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/location_state/share_mode.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/status/user_status_service_impl.dart';

part 'user_status_state.g.dart';

// ignore: library_private_types_in_public_api
class UserStatusState = _UserStatusState with _$UserStatusState;

/// Manages the Status of the User.
///
/// The user status is defined by the contacts sharing location with them and
/// the location mode (active or passive).
abstract class _UserStatusState with Store {
  /// Service that will handle all the communication with the server.
  /// regarding the user status
  final UserStatusService userStatusService;

  /// List of contacts currently sharing location with this user.
  @observable
  List<ContactLocation> contacts = [];

  /// This mode defines frecuency of location updates for the current user.
  ///
  /// If there is no user with the app opened close enough to us, we will be
  /// [passive] and update our location less frecuently.
  ///
  /// If at least one of our friends is close enough and seeing us in the map,
  /// we will be [active] and will send more location updates.
  @observable
  ShareLocationMode locationMode = ShareLocationMode.passive;

  /// Callback that will be triggered when the contacts sharing location with
  /// us change in any way.
  late Function(List<ContactLocation>) onContactsRefUpdateCallback =
      (contacts) => setContactList(contacts);

  /// Callback that will be triggered when the server determines that we should
  /// change the location update frecuency.
  late Function(ShareLocationMode) onLocationModeUpdateCallback =
      (locationMode) => setLocationMode(locationMode);

  /// Builds a [UserStatusState].
  ///
  /// The optional [UserStatusService] argument is used for testing purposes.
  _UserStatusState({UserStatusService? userStatusService})
      : userStatusService = userStatusService ?? UserStatusService();

  /// Initializes the [userStatusService] listener for changes in the status.
  ///
  /// Calls `onContactsRefsUpdateCallback` when the contacts sharing with us change.
  ///
  /// Calls `onLocationModeUpdateCallback` when our location mode should be changed.
  Future initializeListener() async {
    await userStatusService.setUpListener(
        onContactsRefUpdate: onContactsRefUpdateCallback,
        onLocationModeUpdate: onLocationModeUpdateCallback);
  }

  /// Updates the contacts sharing location with us.
  @action
  void setContactList(List<ContactLocation> newContacts) {
    contacts = newContacts;
  }

  /// Updates the location mode here and in [LocationState].
  @action
  void setLocationMode(ShareLocationMode newMode) {
    locationMode = newMode;
    GetIt.I
        .get<LocationState>()
        .shareLocationService
        .setShareLocationMode(newMode);
  }
}
