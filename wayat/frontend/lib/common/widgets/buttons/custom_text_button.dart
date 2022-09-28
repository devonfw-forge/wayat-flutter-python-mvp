import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

/// Button with text in primary color
class CustomTextButton extends StatelessWidget {
  /// Callback of the widget when pressed
  // Null will set the button as disabled
  final Function()? onPressed;

  /// Text inside the widget
  final String text;

  const CustomTextButton(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          color: ColorTheme.primaryColor,
        ),
      ),
    );
  }
}
