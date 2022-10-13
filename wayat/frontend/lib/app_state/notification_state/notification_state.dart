import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/notification/push_notification.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

part 'notification_state.g.dart';

/// A state of the notifications
// ignore: library_private_types_in_public_api
class NotificationState = _NotificationState with _$NotificationState;

/// Implementation of the state of the notifications, when contacts send or accept friend request
abstract class _NotificationState with Store {
  FirebaseMessaging messagingInstance = FirebaseMessaging.instance;
  PlatformService platformService = PlatformService();

  @observable
  int totalNotifications = 0;

  @observable
  PushNotification? notificationInfo;

  @observable
  bool authorizationStatus = false;

  ///Get permitions from the user
  @action
  Future<void> getPermission() async {
    NotificationSettings settings = await messagingInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    ///check authorizationStatus
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      authorizationStatus = true;
    }

    print('User granted permission: ${settings.authorizationStatus}');
  }

  /// Return notification with [newMessage]
  PushNotification pushNotification(RemoteMessage newMessage) {
    if (platformService.isWeb) {
      // TODO: implement web notification
    }

    if (platformService.targetPlatform == TargetPlatform.android) {
      return PushNotification(
          title: newMessage.notification?.title,
          body: newMessage.notification?.body,
          dataTitle: newMessage.data['title'],
          dataBody: newMessage.data['body']);
    }

    if (platformService.targetPlatform == TargetPlatform.iOS) {
      return PushNotification(
        title: newMessage.data['aps']['alert']['title'],
        body: newMessage.data['aps']['alert']['body'],
        dataTitle: newMessage.data['aps']['alert']['dataTitle'],
        dataBody: newMessage.data['aps']['alert']['dataBody'],
      );
    }
    return PushNotification(
      title: 'No title',
      body: 'No body',
      dataTitle: 'No title data',
      dataBody: 'No body data',
    );
  }

  /// For handling notification when the app is open
  @action
  messagingAppListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
          'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

      notificationInfo = pushNotification(message);
      totalNotifications++;
      if (notificationInfo != null) showNotification();
    });
  }

  // For handling notification when the app is in terminated state
  @action
  messagingTerminatedAppListener() async {
    RemoteMessage? initialMessage = await messagingInstance.getInitialMessage();
    if (initialMessage != null) {
      debugPrint(
          'Message title: ${initialMessage.notification?.title}, body: ${initialMessage.notification?.body}, data: ${initialMessage.data}');

      notificationInfo = pushNotification(initialMessage);
      totalNotifications++;
    }
  }

  /// For handling notification when the app is in background
  /// but not terminated
  @action
  messagingBackgroundAppListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

      notificationInfo = pushNotification(message);
      totalNotifications++;
    });
  }

  showNotification() {
    showSimpleNotification(
      Text(notificationInfo?.title ?? 'No notification title'),
      subtitle: Text(notificationInfo?.body ?? 'No notification body'),
      background: Colors.white,
      foreground: Colors.black,
      leading: NotificationBadge(
          contactIconUrl: notificationInfo?.dataBody ??
              'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
      trailing: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000.0),
            side: const BorderSide(color: Colors.black, width: 1),
          ),
        ),
        onPressed: (() {
          //TODO: hide notification
          //Navigator.of(context).dispose();
        }),
        child: const Text('Dismiss',
            style: TextStyle(fontSize: 14, color: ColorTheme.primaryColor)),
      ),
      duration: const Duration(seconds: 3),
    );
  }

  @action
  registerNotification() async {
    await getPermission();

    if (authorizationStatus) {
      messagingAppListener();
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
}
