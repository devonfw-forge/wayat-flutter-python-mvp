import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:wayat/domain/notification/push_notification.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wayat/services/notification/notification_service.dart';

class NotificationsServiceImpl implements NotificationsService {
  final FirebaseMessaging messagingInstance = FirebaseMessaging.instance;
  final PlatformService platformService = PlatformService();
  HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initialize() async {
    // Check is user accept permissions
    if (await areNotificationsEnabled()) {
      await messagingInstance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      /// Create a new AndroidNotificationChannel instance
      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title// description
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await setUpTokenListener();
      setUpNotificationsForegroundListener();
      recoverLastLostNotification();
      setUpOnAppOpenedWithNotification();
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  /// Register notification when app is launched
  @visibleForTesting
  Future<bool> areNotificationsEnabled() async {
    // Request permissions
    if (platformService.isAndroid) {
      if (await isAndroidPermissionGranted()) {
        return true;
      }
      return await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.requestPermission() ??
          false;
    }
    if (platformService.isIOS) {
      return await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()!
              .requestPermissions(
                alert: true,
                badge: true,
                sound: true,
                critical: true,
              ) ??
          false;
    }
    return false;
  }

  @visibleForTesting
  Future<bool> isAndroidPermissionGranted() async {
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
  }

  /// Gets the notifications token and updates the backend when it changes
  @visibleForTesting
  Future<void> setUpTokenListener() async {
    String? token = await messagingInstance.getToken();
    if (token != null) sendNotificationsToken(token);
    messagingInstance.onTokenRefresh.listen(sendNotificationsToken);
  }

  /// Return notification with [newMessage]
  @visibleForTesting
  PushNotification createPushNotification(RemoteMessage newMessage) {
    if (platformService.isAndroid) {
      return PushNotification(
          action: newMessage.data['action'] ?? "",
          contactName: newMessage.data['contact_name'] ?? "");
    }

    if (platformService.isIOS) {
      return PushNotification(
        action: newMessage.data['aps']['alert']['action'] ?? "",
        contactName: newMessage.data['aps']['alert']['contact_name'] ?? "",
      );
    }
    return PushNotification(action: '', contactName: '');
  }

  /// Listens for upcoming notifications in the foreground
  /// The background listener is handled by the OS
  @visibleForTesting
  void setUpNotificationsForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) =>
        showNotification(createPushNotification(message)));
  }

  /// Shows the last notification if it was received while the app was completely closed
  @visibleForTesting
  Future<void> recoverLastLostNotification() async {
    RemoteMessage? initialMessage = await messagingInstance.getInitialMessage();
    if (initialMessage != null) {
      showNotification(createPushNotification(initialMessage));
    }
  }

  /// Calls a method when the app is opened via the notification
  @visibleForTesting
  void setUpOnAppOpenedWithNotification() {
    //FirebaseMessaging.onMessageOpenedApp.listen(
    //(RemoteMessage message) => showNotification(pushNotification(message)));
  }

  @visibleForTesting
  void showNotification(PushNotification notificationInfo) {
    showSimpleNotification(
        Text(generateNotificationText(
            notificationInfo.action, notificationInfo.contactName)),
        background: Colors.white,
        foreground: Colors.black,
        leading: const NotificationBadge());
  }

  @visibleForTesting
  String generateNotificationText(String action, String contactName) {
    if (action == 'ACCEPTED_FRIEND_REQUEST') {
      return contactName + appLocalizations.acceptedFriendRequest;
    }
    if (action == 'RECEIVED_FRIEND_REQUEST') {
      return contactName + appLocalizations.receivedFriendRequest;
    }
    return '';
  }

  @visibleForTesting
  Future<void> sendNotificationsToken(String token) async {
    await httpProvider
        .sendPostRequest(APIContract.pushNotification, {"token": token});
  }
}
