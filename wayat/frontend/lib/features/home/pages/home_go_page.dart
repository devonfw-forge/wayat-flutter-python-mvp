import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
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
        appBar: (platformService.wideUi || platformService.isDesktopOrWeb)
            ? null
            : const PreferredSize(
                preferredSize: Size.fromHeight(40), child: CustomAppBar()),
        body: AdaptiveNavigationScaffold(
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
          extendBody: true,
          destinations: scaffoldDestinations,
          navigationTypeResolver: navigationTypeResolver,
        ));
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
