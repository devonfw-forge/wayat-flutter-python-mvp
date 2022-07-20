import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/bottom_navigation_bar/notification_icon_counter.dart';
import 'package:wayat/lang/lang_singleton.dart';


final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;

List<BottomNavigationBarItem> bottomNavigatorItems = [
  BottomNavigationBarItem(
    icon: const Icon(Icons.home),
    label: appLocalizations.home,
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
