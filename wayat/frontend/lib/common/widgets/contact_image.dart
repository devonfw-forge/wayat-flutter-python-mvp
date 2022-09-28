import 'package:flutter/material.dart';

/// Circled contact image with colored border
class ContactImage extends StatelessWidget {
  /// URL of contact image
  final String imageUrl;

  /// Radius of the circle
  final double radius;

  /// Linewidth of circle border
  final double lineWidth;

  /// Border's color, black by default if null
  final Color? color;

  const ContactImage(
      {Key? key,
      required this.imageUrl,
      required this.radius,
      required this.lineWidth,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundColor: color ?? Colors.black,
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: radius - lineWidth,
        ));
  }
}
