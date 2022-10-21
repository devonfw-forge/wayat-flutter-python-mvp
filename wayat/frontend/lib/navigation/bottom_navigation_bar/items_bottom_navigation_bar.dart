import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:wayat/lang/app_localizations.dart';

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
