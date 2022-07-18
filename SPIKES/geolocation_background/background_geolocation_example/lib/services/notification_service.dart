import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channel = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestAlertPermission: false,
            requestBadgePermission: false);

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(channel, 'Channel name',
          channelDescription: 'Description',
          playSound: true,
          priority: Priority.high,
          importance: Importance.high);

  Future<void> showNotifications() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      "Notification Title",
      "This is the Notification Body!",
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> scheduleNotifications() async {
    debugPrint(
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2)).toString());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Notification Title",
        "This is the Notification Body!",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> sendLocationNotification(LocationData location) async {
    debugPrint(
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2)).toString());

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "New Location",
        "${location.latitude} ${location.longitude}",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

void selectNotification(String? payload) async {
  //handle your logic here
}
