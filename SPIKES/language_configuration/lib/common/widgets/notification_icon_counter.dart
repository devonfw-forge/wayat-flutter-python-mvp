import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class NotificationsCounter extends StatefulWidget {
  const NotificationsCounter({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationsCounter> createState() => _NotificationsCounterState();
}

class _NotificationsCounterState extends State<NotificationsCounter> {
  int counterNotification = 0;
  @override
  Widget build(BuildContext context) {
    return counterNotification > 0
        ? Badge(
            badgeContent: Text(
              counterNotification.toString(),
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
            badgeColor: const Color.fromARGB(255, 98, 0, 116),
            child: const Icon(Icons.notifications))
        : const Icon(Icons.notifications);
  }
}
