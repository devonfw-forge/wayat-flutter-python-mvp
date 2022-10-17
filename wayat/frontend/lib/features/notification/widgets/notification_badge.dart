import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';

/// Notification badge which user get in the top of screen when the app is open and active
class NotificationBadge extends StatelessWidget {
  const NotificationBadge({Key? key}) : super(key: key);

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
            image:
                const Image(image: AssetImage('assets/images/wayat_icon.png'))
                    .image,
            fit: BoxFit.cover),
      ),
    );
  }
}
