import 'package:flutter/material.dart';

class ContactImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ContactImage({Key? key, required this.imageUrl, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ));
  }
}
