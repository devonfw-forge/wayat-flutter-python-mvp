import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomCard({required this.text, Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(text,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 16)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
                child:
                    Icon(Icons.arrow_forward, color: Colors.black87, size: 20)),
          )
        ]),
      ),
    );
  }
}
