import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:wayat/domain/notification/push_notification.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';
import 'package:wayat/navigation/initial_route.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/services/notification/notification_service.dart';

class NotificationsServiceImpl implements NotificationsService {
  final FirebaseMessaging messagingInstance = FirebaseMessaging.instance;
  final PlatformService platformService = PlatformService();
  HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static int id = 0;

  /// Called when a notification is received with the app in the background or terminated.
  ///
  /// The annotation 'pragma('vm:entry-point')' is necessary because of an issue
  /// from Flutter 3.3.0 onwards, provoking that, if missing, this function
  /// would be removed during the tree shaking when building for release mode.
  @pragma('vm:entry-point')
  static Future<void> onBackMessage(RemoteMessage message) async {
    PushNotification notification =
        await PushNotification.fromRemoteMessage(message);

    await flutterLocalNotificationsPlugin.show(
        ++id, 'WAYAT', notification.text, notificationDetails,
        payload: notification.payload);

    return;
  }

  static initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_name');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails('wayat_android_channel', 'wayat',
        channelDescription: 'wayat_friends_notifications',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'),
  );

  static int lastNotificationId = -1;
  static Future<void> checkIfOpenedWithNotification(
      {required Function(String?) onOpenedWithNotification}) async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await NotificationsServiceImpl.flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      if (lastNotificationId !=
          notificationAppLaunchDetails.notificationResponse!.id) {
        onOpenedWithNotification(
            notificationAppLaunchDetails.notificationResponse?.payload);
        lastNotificationId =
            notificationAppLaunchDetails.notificationResponse!.id!;
      }
    }
  }

  @override
  Future<void> initialize() async {
    await initializeLocalNotifications();

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
      recoverLastLostNotification();
      setUpNotificationsForegroundListener();
      setUpNotificationsBackgroundListener();
    } else {
      debugPrint('User declined or has not accepted permission');
    }

    await NotificationsServiceImpl.checkIfOpenedWithNotification(
        onOpenedWithNotification: (String? payload) {
      GetIt.I.get<InitialLocationProvider>().initialLocation =
          InitialLocation.fromValue(payload ?? "");
    });
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

  /// The background listener is handled by the OS
  @visibleForTesting
  void setUpNotificationsForegroundListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      PushNotification pushNotification =
          await PushNotification.fromRemoteMessage(message);
      showNotification(pushNotification,
          onNotificationTapped: () => GetIt.I
              .get<GlobalKey<NavigatorState>>()
              .currentContext
              ?.go(pushNotification.payload));
    });
  }

  /// Listens for upcoming notifications in the foreground
  /// The background listener is handled by the OS
  @visibleForTesting
  void setUpNotificationsBackgroundListener() {
    FirebaseMessaging.onBackgroundMessage(onBackMessage);
  }

  /// Shows the last notification if it was received while the app was completely closed
  @visibleForTesting
  Future<void> recoverLastLostNotification() async {
    RemoteMessage? initialMessage = await messagingInstance.getInitialMessage();
    if (initialMessage != null) {
      showNotification(
          await PushNotification.fromRemoteMessage(initialMessage));
    }
  }

  @visibleForTesting
  void showNotification(PushNotification notificationInfo,
      {Function()? onNotificationTapped}) {
    showOverlayNotification((context) {
      return GestureDetector(
        onTap: onNotificationTapped,
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SafeArea(
              child: ListTile(
                leading: SizedBox.fromSize(
                    size: const Size(40, 40), child: const NotificationBadge()),
                title: Text(notificationInfo.text),
              ),
            ),
          ),
        ),
      );
    }, duration: const Duration(milliseconds: 2000));
  }

  @visibleForTesting
  Future<void> sendNotificationsToken(String token) async {
    await httpProvider
        .sendPostRequest(APIContract.pushNotification, {"token": token});
  }
}
