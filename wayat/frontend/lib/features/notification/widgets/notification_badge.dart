import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

class NotificationBadge extends StatelessWidget {
  final String contactIconUrl;
  const NotificationBadge({Key? key, required this.contactIconUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      key: const Key("contact_icon"),
      decoration: BoxDecoration(
        color: ColorTheme.primaryColor,
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(contactIconUrl), fit: BoxFit.cover),
      ),
    );
  }
}
