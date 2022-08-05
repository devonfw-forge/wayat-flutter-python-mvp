import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final Color backgroundColor;

  const CircleIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  //final ContactLocation contact;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.black, width: 1),
            shape: BoxShape.circle),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(1000),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
