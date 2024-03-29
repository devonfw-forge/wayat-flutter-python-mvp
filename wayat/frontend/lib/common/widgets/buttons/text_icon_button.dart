import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

/// Button without border with text and icon
class CustomTextIconButton extends StatelessWidget {
  /// Callback when widget is pressed
  final Function onPressed;

  /// Text displayed inside button
  final String text;

  /// Icon from Material/Cupertino design
  final IconData icon;

  final double? fontSize;

  const CustomTextIconButton(
      {required this.text,
      required this.icon,
      required this.onPressed,
      this.fontSize,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () => onPressed(),
        icon: Icon(
          icon,
          color: ColorTheme.primaryColor,
        ),
        label: Text(
          text,
          style: TextStyle(color: ColorTheme.primaryColor, fontSize: fontSize),
        ));
  }
}
