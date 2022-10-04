import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:platform_widgets/ui/apphomepage.dart';
import 'package:platform_widgets/utils/color_utils.dart' as ColorUtils;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      material: (_, __) => MaterialAppData(theme: ColorUtils.materialThemeData),
      cupertino: (_, __) => CupertinoAppData(theme: ColorUtils.cupertinoTheme),
      home: AppHomePage(title: 'Flutter Platform Aware App'),
    );
  }
}
