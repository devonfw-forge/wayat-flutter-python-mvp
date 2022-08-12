import 'package:flutter/material.dart';

class ContactsSectionTitle extends StatelessWidget {
  const ContactsSectionTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
    );
  }
}
