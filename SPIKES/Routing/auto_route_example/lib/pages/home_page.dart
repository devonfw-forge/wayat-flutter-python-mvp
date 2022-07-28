import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/navigation/app_router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
        routes: const [
          NavigateToListRoute(),
          BottomMenuRoute(),
          BottomMenuSecondRoute()
        ],
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);

          return Scaffold(
            appBar: AppBar(title: const Text("Home page")),
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_rounded), label: "Bottom menu"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_rounded),
                    label: "Bottom Menu 2"),
              ],
            ),
          );
        });
  }
}
