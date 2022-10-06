import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:platform_widgets/ui/screen_tab_one.dart';
import 'package:platform_widgets/ui/screen_tab_three.dart';
import 'package:platform_widgets/ui/screen_tab_two.dart';
import 'package:platform_widgets/utils/color_utils.dart' as ColorUtils;
import 'package:platform_widgets/utils/constants.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen> {
  int _tabSelectedIndex = 0;
  String title = txtDashboard;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          title,
          style: ColorUtils.toolbarTextStyle,
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(
          transitionBetweenRoutes: false,
        ),
      ),
      material: (_, __) => MaterialScaffoldData(),
      body: getTabScreen(_tabSelectedIndex),
      bottomNavBar: PlatformNavBar(
          currentIndex: _tabSelectedIndex,
          itemChanged: (index) {
            setState(() {
              _tabSelectedIndex = index;
              title = getScreenTitle(index);
            });
          },
          backgroundColor: ColorUtils.bottomTabsBackground,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.apps, color: Colors.grey),
              label: txtDashboard,
              activeIcon: Icon(Icons.apps, color: Colors.white),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.update, color: Colors.grey),
              label: txtFeeds,
              activeIcon: Icon(Icons.update, color: Colors.white),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.grey),
              label: txtSettings,
              activeIcon: Icon(Icons.settings, color: Colors.white),
            )
          ]),
    );
  }

  ////Return corresponding screen per index
  Widget getTabScreen(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return ScreenTabTwo();
      case 2:
        return ScreenTabThree();
      default:
        return ScreenTabOne();
    }
  }

  ////Return title of the screen
  String getScreenTitle(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return txtFeeds;
      case 2:
        return txtSettings;
      default:
        return txtDashboard;
    }
  }
}
