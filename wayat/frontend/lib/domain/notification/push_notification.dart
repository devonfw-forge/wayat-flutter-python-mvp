import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/lang/app_localizations.dart';

class PushNotification {
  final String text;

  PushNotification({required this.text});

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

    String text = (action == 'ACCEPTED_FRIEND_REQUEST')
        ? contactName + appLocalizations.acceptedFriendRequest
        : (action == 'RECEIVED_FRIEND_REQUEST')
            ? action = contactName + appLocalizations.receivedFriendRequest
            : "";

    return PushNotification(text: text);
  }
}
