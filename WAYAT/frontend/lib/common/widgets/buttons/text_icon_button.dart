import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wayat/common/theme/colors.dart';

class CustomTextIconButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final IconData icon;

  const CustomTextIconButton(
      {required this.text,
      required this.icon,
      required this.onPressed,
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
          style: const TextStyle(color: ColorTheme.primaryColor),
        ));
  }
}
