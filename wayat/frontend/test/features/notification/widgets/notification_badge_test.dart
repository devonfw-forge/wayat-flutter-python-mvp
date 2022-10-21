import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';

import '../../../test_common/test_app.dart';

void main() async {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  testWidgets('Contact image', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: const NotificationBadge()));
    expect(find.byKey(const Key("contact_icon")), findsOneWidget);
  });
}
