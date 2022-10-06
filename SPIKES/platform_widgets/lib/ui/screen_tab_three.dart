import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platform_widgets/utils/color_utils.dart' as ColorUtils;
import 'package:platform_widgets/utils/constants.dart';

class ScreenTabThree extends StatelessWidget {
  const ScreenTabThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        txtSettings,
        style: ColorUtils.tabsContentText,
      ),
    );
  }
}
