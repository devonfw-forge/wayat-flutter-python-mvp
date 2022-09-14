import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const CustomTextButton(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: (onPressed == null)
            ? const TextStyle(color: Colors.grey, fontSize: 15)
            : const TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }
}
