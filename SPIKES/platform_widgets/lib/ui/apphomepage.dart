import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:platform_widgets/ui/first_screen.dart';
import 'package:platform_widgets/utils/color_utils.dart' as ColorUtils;

class AppHomePage extends StatefulWidget {
  const AppHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(
            widget.title,
            style: ColorUtils.toolbarTextStyle,
          ),
          cupertino: (_, __) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        material: (_, __) => MaterialScaffoldData(),
        body: FirstScreen());
  }
}
