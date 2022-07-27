import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
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
        side: const BorderSide(width: 1),
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }
}
