import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/common/appbar/appbar.dart';
import 'package:wayat/navigation/app_router.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        ContactsRoute(),
        ContactsRoute(),
        ContactsRoute(),
        ContactsRoute(),
        ContactsRoute()
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: const Appbar(),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: bottomNavigationBarItems),
        );
      },
    );
  }
}
