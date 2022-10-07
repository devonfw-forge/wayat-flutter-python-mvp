import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:wayat/domain/notification/push_notification.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

part 'notification_state.g.dart';

/// A state of the notifications
// ignore: library_private_types_in_public_api
class NotificationState = _NotificationState with _$NotificationState;

/// Implementation of the state of the notifications, when contacts send or accept friend request
abstract class _NotificationState with Store {
  FirebaseMessaging messagingInstance = FirebaseMessaging.instance;
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

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
    return PushNotification(
      title: newMessage.notification?.title,
      body: newMessage.notification?.body,
      dataTitle: newMessage.data['title'],
      dataBody: newMessage.data['body'],
    );
  }

  // For handling notification when the app is in terminated state
  @action
  void messagingTerminatedAppListener() async {
    RemoteMessage? initialMessage = await messagingInstance.getInitialMessage();
    if (initialMessage != null) {
      notificationInfo = pushNotification(initialMessage);
      totalNotifications++;
    }
  }

  /// For handling notification when the app is in background
  /// but not terminated
  void messagingBackgroundAppListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notificationInfo = pushNotification(message);
      totalNotifications++;
    });
  }

  void showNotification() {
    showSimpleNotification(
      Text(notificationInfo!.title!),
      leading: NotificationBadge(totalNotifications: totalNotifications),
      subtitle: Text(notificationInfo!.body!),
      background: Colors.cyan.shade700,
      duration: const Duration(seconds: 3),
    );
  }

  void registerNotification() async {
    getPermission();

    if (authorizationStatus) {
      FirebaseMessaging.onMessage.listen((RemoteMessage newMessage) {
        debugPrint(
            'Message title: ${newMessage.notification?.title}, body: ${newMessage.notification?.body}, data: ${newMessage.data}');

        notificationInfo = pushNotification(newMessage);
        totalNotifications++;

        if (notificationInfo != null) showNotification();
      });
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<bool> sendToken(String token) async {
    bool done = (await httpProvider.sendPostRequest(
                    APIContract.pushNotification, {"token": token}))
                .statusCode /
            10 ==
        20;
    return done;
  }
}
