import 'package:flutter/material.dart';
import 'package:wayat/common/bottom_navigation_bar/notification_icon_counter.dart';

List<BottomNavigationBarItem> bottomNavigatorItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
    backgroundColor: Colors.purple,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.people),
    label: 'Contacts',
    backgroundColor: Colors.purple,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.add_circle),
    label: 'Add Event',
    backgroundColor: Colors.purple,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.calendar_month),
    label: 'My Events',
    backgroundColor: Colors.purple,
  ),
  const BottomNavigationBarItem(
    icon: NotificationsCounter(),
    label: 'Notifications',
    backgroundColor: Colors.purple,
  ),
];
