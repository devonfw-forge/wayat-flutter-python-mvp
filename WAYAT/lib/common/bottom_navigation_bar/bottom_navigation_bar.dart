import 'package:flutter/material.dart';
import 'package:wayat/common/bottom_navigation_bar/notification_icon_counter.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.people),
          label: 'Contacts',
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle),
          label: 'Add Event',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: 'My Events',
        ),
        NavigationDestination(
          icon: NotificationsCounter(),
          label: 'Notifications',
        ),
      ],
    );
  }
}
