import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/navigation/bottom_navigation_bar/notification_icon_counter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final AppLocalizations appLocalizations = GetIt.I.get<LangSingleton>().get();

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
