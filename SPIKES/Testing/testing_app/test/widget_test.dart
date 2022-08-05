// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/src/page/login_page.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.

  Widget testWidget = MediaQuery(data: MediaQueryData(), child: MaterialApp(home: Scaffold(body: LoginPage())));

  testWidgets(
    'MyWidget has a title and message', 
    (tester) async {
      await tester.pumpWidget(testWidget);
      // expect(find.widgetWithText(CustomWayatTitle, 'wayat'), findsOneWidget);
    }
  );
}