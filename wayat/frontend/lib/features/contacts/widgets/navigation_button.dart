import 'package:flutter/material.dart';

/// Button showing a text and arrow to right
class NavigationButton extends StatelessWidget {
  /// Callback triggered when tapping on button
  final Function()? onTap;

  /// Text displayed besides arrow icon
  final String text;

  const NavigationButton({required this.onTap, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(children: [
          Text(text,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),
          const Icon(
            Icons.chevron_right,
            color: Colors.black54,
          )
        ]),
      ),
    );
  }
}
