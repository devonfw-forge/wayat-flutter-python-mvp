import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Main page with tabs of home, contacts and profile
///
/// When the platform is Desktop or Web or a tablet, it shows a side navigation bar.
///
/// When the platform is Android or iOS and the screen is tall, it shows a bottom navigation bar.
class HomePage extends StatelessWidget {
  final PlatformService platformService;

  HomePage({
    PlatformService? platformService,
    Key? key,
  })  : platformService = platformService ?? PlatformService(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomeMapRoute(),
        ContactsWrapper(),
        ProfileWrapper(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: 
              (platformService.wideUi || platformService.isDesktopOrWeb) ? null : const PreferredSize(
              preferredSize: Size.fromHeight(40), child: CustomAppBar()),
          body: Row(children: [
            if (platformService.wideUi || platformService.isDesktopOrWeb)
              NavigationRail(
                destinations: navigationRailDestinations,
                selectedIndex: tabsRouter.activeIndex,
                backgroundColor: Colors.black,
                selectedIconTheme: const IconThemeData(color: Colors.white),
                unselectedIconTheme: const IconThemeData(color: Colors.white54),
                selectedLabelTextStyle: const TextStyle(color: Colors.white),
                unselectedLabelTextStyle:
                    const TextStyle(color: Colors.white54),
                onDestinationSelected: (index) =>
                    tabsRouter.setActiveIndex(index),
              ),
            Expanded(child: child)
          ]),
          bottomNavigationBar:
              (!platformService.wideUi && !platformService.isDesktopOrWeb)
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.black,
                      child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          backgroundColor: Colors.black,
                          selectedItemColor: Colors.white,
                          unselectedItemColor: Colors.white54,
                          currentIndex: tabsRouter.activeIndex,
                          onTap: tabsRouter.setActiveIndex,
                          items: bottomNavigationBarItems),
                    )
                  : null,
        );
      },
    );
  }
}
