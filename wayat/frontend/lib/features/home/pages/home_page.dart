import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/navigation/app_router.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  final AppLocalizations appLocalizations =
      GetIt.I.get<LangSingleton>().appLocalizations;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AutoTabsRouter(
      routes: [
        const HomeMapRoute(),
        const CreateEventRoute(),
        ContactsRoute(),
        const NotificationsRoute(),
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
