import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final Function onPressed;
  final String text;
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
        primary: Colors.black,
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
