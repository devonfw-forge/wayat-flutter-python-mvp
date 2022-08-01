import 'package:flutter/material.dart';
import 'package:wayat/lang/app_localizations.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems = [
  BottomNavigationBarItem(
    icon: const Icon(Icons.map),
    label: appLocalizations.appTitle,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.event_note_outlined),
    label: appLocalizations.events,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.contacts_outlined),
    label: appLocalizations.contacts,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.person_outline),
    label: appLocalizations.profile,
  ),
];
