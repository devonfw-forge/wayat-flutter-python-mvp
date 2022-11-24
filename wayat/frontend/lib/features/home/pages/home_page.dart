import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/features/home/pages/home_tabs.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
// ignore: depend_on_referenced_packages
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';

/// Main page with tabs of home, contacts and profile
///
/// When the platform is Desktop or Web or a tablet, it shows a side navigation bar.
///
/// When the platform is Android or iOS and the screen is tall, it shows a bottom navigation bar.
class HomePage extends StatelessWidget {
  final PlatformService platformService = GetIt.I.get<PlatformService>();
  final HomeTab selectedSection;
  final Widget child;

  HomePage({super.key, required this.selectedSection, required this.child});

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
      appBar: (platformService.wideUi || platformService.isDesktopOrWeb)
          ? null
          : const PreferredSize(
              preferredSize: Size.fromHeight(40), child: CustomAppBar()),
      resizeToAvoidBottomInset: false,
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
      navigationTypeResolver: navigationTypeResolver,
    );
  }

  NavigationType navigationTypeResolver(BuildContext context) {
    if (_isLargeScreen(context) || _isMediumScreen(context)) {
      return NavigationType.rail;
    } else {
      return NavigationType.bottom;
    }
  }

  bool _isLargeScreen(BuildContext context) =>
      getWindowType(context) >= AdaptiveWindowType.large;
  bool _isMediumScreen(BuildContext context) =>
      getWindowType(context) == AdaptiveWindowType.medium;
}
