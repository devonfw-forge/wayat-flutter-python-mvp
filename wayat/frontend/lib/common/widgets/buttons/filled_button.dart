import 'package:flutter/material.dart';

/// Button with solid infill and text
class CustomFilledButton extends StatelessWidget {
  /// Callback executed when the widget is pressed
  final Function onPressed;

  /// Text contained in the button
  final String text;

  /// Whether button must appears as enabled
  final bool enabled;

  const CustomFilledButton(
      {required this.text,
      required this.onPressed,
      required this.enabled,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000.0),
        ),
      ),
      onPressed: (enabled) ? () => onPressed() : null,
      child: Text(
        text,
        style: TextStyle(
            color: (enabled) ? Colors.white : Colors.black12, fontSize: 15),
      ),
    );
  }
}
