import 'package:flutter/material.dart';
import 'package:wayat/lang/app_localizations.dart';

/// Defines the items present in the [BottomNavigationBar] in [HomePage]
List<BottomNavigationBarItem> bottomNavigationBarItems = [
  BottomNavigationBarItem(
    icon: const Icon(Icons.map),
    label: appLocalizations.appTitle,
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

/// Defines the items present in the [NavigationRail] in [HomePage] when the screen is wide
List<NavigationRailDestination> navigationRailDestinations = [
  NavigationRailDestination(
    icon: const Icon(Icons.map),
    label: Text(appLocalizations.appTitle),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.contacts_outlined),
    label: Text(appLocalizations.contacts),
  ),
  NavigationRailDestination(
    icon: const Icon(Icons.person_outline),
    label: Text(appLocalizations.profile),
  ),
];
