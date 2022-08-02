// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/src/page/home_page.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets(
    'MyWidget has a title and message', 
    (tester) async {
      await tester.pumpWidget(const TestWidget(title: 'T', message: 'M'));
      expect(find.text('T'), findsOneWidget);
      expect(find.text('M'), findsOneWidget);
    }
  );
}