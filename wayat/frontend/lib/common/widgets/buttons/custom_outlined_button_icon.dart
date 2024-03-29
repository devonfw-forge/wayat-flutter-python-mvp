import 'package:flutter/material.dart';

/// Rounded border Button with text and Icon
class CustomOutlinedButtonIcon extends StatelessWidget {
  /// Callback when widget is pressed
  final void Function()? onPressed;

  /// Text inside the widget
  final String text;

  /// Icon from Material/Cupertino design
  final IconData icon;

  const CustomOutlinedButtonIcon(
      {required this.text,
      required this.onPressed,
      required this.icon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000.0),
        ),
        side: (onPressed == null) ? null : const BorderSide(width: 1),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black),
      label: Text(
        text,
        style: (onPressed == null)
            ? const TextStyle(color: Colors.grey, fontSize: 15)
            : const TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }
}
