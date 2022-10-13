import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';

void main() async {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  Widget createApp(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: body,
        ),
      ),
    );
  }

  testWidgets('Contact image', (tester) async {
    await tester.pumpWidget(createApp(const NotificationBadge(
      contactIconUrl:
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    )));
    expect(find.byKey(const Key("contact_icon")), findsOneWidget);
  });
}
