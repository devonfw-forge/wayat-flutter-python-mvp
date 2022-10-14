import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/features/home/pages/home_tabs.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Main page with tabs of home, contacts and profile
///
/// When the platform is Desktop or Web or a tablet, it shows a side navigation bar.
///
/// When the platform is Android or iOS and the screen is tall, it shows a bottom navigation bar.
class HomeGoPage extends StatelessWidget {
  final PlatformService platformService;
  final HomeTab selectedSection;
  final Widget child;

  HomeGoPage(
      {required this.selectedSection,
      required this.child,
      PlatformService? platformService,
      super.key})
      : platformService = platformService ?? PlatformService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AdaptiveNavigationScaffold(
      body: child,
      selectedIndex: selectedSection.index,
      onDestinationSelected: (int index) {
        switch (HomeTab.values[index]) {
          case HomeTab.map:
            context.go("/map");
            break;
          case HomeTab.contacts:
            context.go("/contacts");
            break;
          case HomeTab.profile:
            context.go("/profile");
            break;
        }
      },
      destinations: scaffoldDestinations,
    ));
  }
}
