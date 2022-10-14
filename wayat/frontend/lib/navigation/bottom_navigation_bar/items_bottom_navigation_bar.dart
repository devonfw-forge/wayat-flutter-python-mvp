import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:wayat/lang/app_localizations.dart';

/// Defines the items present in the [BottomNavigationBar] in [HomePage]
List<BottomNavBarItemGoRoute> bottomNavigationBarItems = [
  BottomNavBarItemGoRoute(
    initialLocation: '/map',
    icon: const Icon(Icons.map),
    label: appLocalizations.appTitle,
  ),
  BottomNavBarItemGoRoute(
    initialLocation: '/contacts',
    icon: const Icon(Icons.contacts_outlined),
    label: appLocalizations.contacts,
  ),
  BottomNavBarItemGoRoute(
    initialLocation: '/profile',
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

class BottomNavBarItemGoRoute extends BottomNavigationBarItem {
  final String initialLocation;

  BottomNavBarItemGoRoute(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);
}

/// Defines the items present in the [BottomNavigationBar] in [HomePage]
List<AdaptiveScaffoldDestination> scaffoldDestinations = [
  AdaptiveScaffoldDestination(
    icon: Icons.map,
    title: appLocalizations.appTitle,
  ),
  AdaptiveScaffoldDestination(
    icon: Icons.contacts_outlined,
    title: appLocalizations.contacts,
  ),
  AdaptiveScaffoldDestination(
    icon: Icons.person_outline,
    title: appLocalizations.profile,
  ),
];
