import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:wayat/domain/notification/push_notification.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wayat/services/notification/notification_service_impl.dart';

part 'notification_state.g.dart';

/// A state of the notifications
// ignore: library_private_types_in_public_api
class NotificationState = _NotificationState with _$NotificationState;

/// Implementation of the state of the notifications, when contacts send or accept friend request
abstract class _NotificationState with Store {
  FirebaseMessaging messagingInstance = FirebaseMessaging.instance;
  PlatformService platformService = PlatformService();

  @observable
  bool authorizationStatus = false;

  @observable
  Stream<String> _tokenStream = const Stream<String>.empty();

  /// Create the channel on the device (if a channel with an id already exists, it will be updated)
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Create a new AndroidNotificationChannel instance
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title// description
    importance: Importance.max,
  );

  /// Initialize Android settings
  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('app_icon');

  /// Initialization Settings for iOS devices
  final DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  /// Android notification details
  final AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    channelDescription: 'channel description',
    importance: Importance.max,
    priority: Priority.max,
    playSound: true,
  );

  /// iOS notification details
  final DarwinNotificationDetails iosNotificationDetails =
      const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    badgeNumber: null,
  );

  Future<NotificationDetails> notificationDetails(
      PushNotification notificationInfo) async {
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    return platformChannelSpecifics;
  }

  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      authorizationStatus = granted;
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      authorizationStatus = granted ?? false;
    }
  }

  /// Register notification when app is launched
  @action
  registerNotification() async {
    // Request permissions
    await isAndroidPermissionGranted();
    await requestPermissions();

    // Check is user accept permissions
    if (authorizationStatus) {
      messagingAppListener();
      await getToken();
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    await messagingInstance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Set token if refreshed
  void setToken(String token) {
    NotificationServiceImpl().sendCurrentUserToken(token);
  }

  /// Get FCM token
  Future<void> getToken() async {
    String? token = await messagingInstance.getToken();
    if (token != null) setToken(token);
    _tokenStream = messagingInstance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  /// Return notification with [newMessage]
  PushNotification pushNotification(RemoteMessage newMessage) {
    if (platformService.targetPlatform == TargetPlatform.android) {
      return PushNotification(
          action: newMessage.notification!.title ?? 'No notification title',
          contact_name: newMessage.notification!.body ?? '');
    }

    if (platformService.targetPlatform == TargetPlatform.iOS) {
      return PushNotification(
        action: newMessage.data['aps']['alert']['title'],
        contact_name: newMessage.data['aps']['alert']['body'],
      );
    }
    return PushNotification(action: '', contact_name: '');
  }

  /// For handling notification when the app is open
  messagingAppListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      PushNotification notificationInfo = pushNotification(message);
      showNotification(notificationInfo);
    });
  }

  // For handling notification when the app is in terminated state
  @action
  messagingTerminatedAppListener() async {
    RemoteMessage? initialMessage = await messagingInstance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notificationInfo = pushNotification(initialMessage);
      notificationDetails(notificationInfo);
    }
  }

  /// For handling notification when the app is in background
  /// but not terminated
  @action
  messagingBackgroundAppListener() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notificationInfo = pushNotification(message);
      notificationDetails(notificationInfo);
    });
  }

  showNotification(PushNotification notificationInfo) {
    showSimpleNotification(
      Text(notificationText(notificationInfo.action, notificationInfo.contact_name)),
      // subtitle: Text(notificationInfo.contact_name),
      background: Colors.white,
      foreground: Colors.black,
      leading: const NotificationBadge(),
    );
    const Duration(seconds: 10);
  }

  String notificationText(String action, String contactName) {

    if (action == 'ACCEPTED_FRIEND_REQUEST') {
      return contactName + appLocalizations.acceptedFriendRequest;
    }
    if (action == 'RECEIVED_FRIEND_REQUEST') {
      return contactName + appLocalizations.receivedFriendRequest;
    }
    return '';
  }
}
