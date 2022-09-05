import 'package:flutter/material.dart';

class ContactImage extends StatelessWidget {
  final String imageUrl;

  final double radius;

  final double lineWidth;

  const ContactImage(
      {Key? key,
      required this.imageUrl,
      required this.radius,
      required this.lineWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: radius - lineWidth,
        ));
  }
}
