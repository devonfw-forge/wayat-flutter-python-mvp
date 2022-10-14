import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/notification/push_notification.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wayat/services/notification/mock/notification_service_impl.dart';

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

  Future<NotificationDetails> notificationDetails() async {
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      print(details.notificationResponse?.payload);
    }

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
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
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
    /// Request permissions
    await isAndroidPermissionGranted();
    await requestPermissions();

    /// Check is user accept permissions
    if (authorizationStatus) {
      messagingAppListener();

      /// get and
      getToken();
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
    print(
        '-----------------------------------------Send refreshed token to backend: $token');
  }

  /// Get FCM token
  void getToken() {
    messagingInstance.getToken().then((token) {
      if (token != null) setToken(token);
      print(
          '-----------------------------------------Send token to backend: $token');
    });
    _tokenStream = messagingInstance.onTokenRefresh;
    _tokenStream.listen(setToken);
  }

  /// Return notification with [newMessage]
  PushNotification pushNotification(RemoteMessage newMessage) {
    if (platformService.isWeb) {
      // TODO: implement web notification
    }

    if (platformService.targetPlatform == TargetPlatform.android) {
      return PushNotification(
        title: newMessage.notification!.title ?? "",
        body: newMessage.notification!.body ?? ""
      );
    }

    if (platformService.targetPlatform == TargetPlatform.iOS) {
      return PushNotification(
        title: newMessage.data['aps']['alert']['title'],
        body: newMessage.data['aps']['alert']['body'],
      );
    }
    return PushNotification(
      title: 'No title',
      body: 'No body'
    );
  }

  /// For handling notification when the app is open
  messagingAppListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
      notificationInfo = pushNotification(initialMessage);
      totalNotifications++;
      notificationDetails();
    }
  }

  /// For handling notification when the app is in background
  /// but not terminated
  @action
  messagingBackgroundAppListener() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notificationInfo = pushNotification(message);
      totalNotifications++;
      notificationDetails();
    });
  }

  showNotification() {
    showSimpleNotification(
      Text(notificationInfo?.title ?? 'No notification title'),
      subtitle: Text(notificationInfo?.body ?? 'No notification body'),
      background: Colors.white,
      foreground: Colors.black,
      leading: NotificationBadge(),
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
      duration: const Duration(seconds: 5),
    );
  }
}
