import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/lang/app_localizations.dart';

class PushNotification {
  final String text;
  final String payload;

  PushNotification({required this.text, required this.payload});

  static fromRemoteMessage(RemoteMessage message) async {
    if (!GetIt.I.isRegistered<AppConfigState>()) {
      AppConfigState appConfigState = AppConfigState();
      GetIt.I.registerLazySingleton<AppConfigState>(() => appConfigState);
      await appConfigState.initializeLocale();
    }

    String action =
        message.data['action'] ?? message.data['aps']['alert']['action'] ?? "";
    String contactName = message.data['contact_name'] ??
        message.data['aps']['alert']['contact_name'] ??
        "";

    String text = "";
    String payload = "";
    if (action == 'ACCEPTED_FRIEND_REQUEST') {
      text = contactName + appLocalizations.acceptedFriendRequest;
      payload = "/contacts/friends";
    } else if (action == 'RECEIVED_FRIEND_REQUEST') {
      text = contactName + appLocalizations.receivedFriendRequest;
      payload = "/contacts/requests";
    }
    return PushNotification(text: text, payload: payload);
  }
}
