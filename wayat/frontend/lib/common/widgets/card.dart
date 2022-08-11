import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomCard({required this.text, Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(text),
        InkWell(
            onTap: onTap,
            child: const Icon(Icons.arrow_forward,
                color: Colors.black87, size: 16))
      ]),
    );
  }
}
