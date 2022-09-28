import 'package:flutter/material.dart';

/// Rounded border button with text
class CustomOutlinedButton extends StatelessWidget {
  /// Callback called when widget is pressed
  // Null values will disabled the button
  final void Function()? onPressed;

  /// Text displayed in the button
  final String text;

  const CustomOutlinedButton(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000.0),
        ),
        side: (onPressed == null) ? null : const BorderSide(width: 1),
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
