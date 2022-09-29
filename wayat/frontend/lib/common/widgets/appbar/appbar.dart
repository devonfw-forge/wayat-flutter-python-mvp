import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/app_localizations.dart';

/// AppBar with Wayat title centered
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white10,
          statusBarBrightness: Brightness.dark, //Dark icons for Android
          statusBarIconBrightness: Brightness.dark //Dark icons for iOS
          ),
      backgroundColor: Colors.white10,
      elevation: 0,
      centerTitle: true,
      title: Text(
        appLocalizations.appTitle,
        style: const TextStyle(
            color: ColorTheme.primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
