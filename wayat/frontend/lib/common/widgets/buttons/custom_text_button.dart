import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onPressed;
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
