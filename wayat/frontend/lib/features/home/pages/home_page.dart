import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomeMapRoute(),
        //const CreateEventRoute(),
        ContactsWrapper(),
        //const NotificationsRoute(),
        ProfileWrapper(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40), child: CustomAppBar()),
          body: child,
          bottomNavigationBar: Container(
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
          ),
        );
      },
    );
  }
}
