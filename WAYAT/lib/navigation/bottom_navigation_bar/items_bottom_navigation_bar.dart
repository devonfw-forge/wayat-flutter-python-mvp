import 'package:flutter/material.dart';
import 'package:wayat/navigation/bottom_navigation_bar/notification_icon_counter.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
    backgroundColor: Colors.purple,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.people),
    label: appLocalizations.contacts,
    backgroundColor: Colors.purple,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.add_circle),
    label: appLocalizations.addEvents,
    backgroundColor: Colors.purple,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.calendar_month),
    label: appLocalizations.myEvents,
    backgroundColor: Colors.purple,
  ),
  BottomNavigationBarItem(
    icon: const NotificationsCounter(),
    label: appLocalizations.notifications,
    backgroundColor: Colors.purple,
  ),
];
