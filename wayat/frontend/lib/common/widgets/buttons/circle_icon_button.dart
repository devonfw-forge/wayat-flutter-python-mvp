import 'package:flutter/material.dart';

/// Circle button with a Material/Cupertino Icon inside and solid black border
class CircleIconButton extends StatelessWidget {
  /// Callback to be executed when icon is pressed
  final void Function()? onPressed;

  /// Icon from material or cupertino design
  final IconData icon;

  /// Background color in the button
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
