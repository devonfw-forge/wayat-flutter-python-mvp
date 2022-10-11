import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/features/notification/widgets/notification_badge.dart';

void main() async {
  Widget createApp(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: body,
        ),
      ),
    );
  }

  testWidgets('Dynamic dialog is correct', (tester) async {
    await tester.pumpWidget(createApp(const NotificationBadge(
      totalNotifications: 3,
    )));
    expect(find.text('3'), findsOneWidget);
  });
}
