import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platform_widgets/utils/color_utils.dart' as ColorUtils;
import 'package:platform_widgets/utils/constants.dart';

class ScreenTabTwo extends StatelessWidget {
  const ScreenTabTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        txtFeeds,
        style: ColorUtils.tabsContentText,
      ),
    );
  }
}
