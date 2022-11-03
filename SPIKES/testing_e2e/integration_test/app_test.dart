import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:testing_e2e/main.dart' as app;
import 'package:testing_e2e/pages/pages.dart';

Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  bool timerDone = false;
  final timer = Timer(timeout, () => timerDone = true);
  while (timerDone != true) {
    await tester.pump();

    final found = tester.any(finder);
    if (found) {
      timerDone = true;
    }
  }
  timer.cancel();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('taps', (tester) async {
      // Creates the app
      app.main();
      // Wait until the ListTile is displayed. It means that the http request
      // has finished succesfully
      await pumpUntilFound(tester, find.byType(ListTile));

      expect(find.byType(ListTile), findsWidgets);

      // Finds the icon of the first product.
      final Finder firstProduct = find.descendant(
          of: find.byType(ListTile).first, matching: find.byType(IconButton));

      // Emulate a tap on the first product that redirects to the detailed view
      await tester.tap(firstProduct);

      // Trigger a frame.
      await tester.pumpAndSettle();

      expect(find.byType(ItemPage), findsOneWidget);
      // Content of first product
      expect(find.text("Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops"),
          findsOneWidget);

      // Finds the button to return back.
      final Finder back = find.byType(Icon);

      // Emulate a tap on the back button.
      await tester.tap(back);

      // Trigger a frame.
      await tester.pumpAndSettle();
      expect(find.byType(ItemPage), findsNothing);
      // Finds tiles again in the first view
      await pumpUntilFound(tester, find.byType(ListTile));

      // Finds the icon of the last product.
      final Finder lastProduct = find.descendant(
          of: find.byType(ListTile).last, matching: find.byType(IconButton));

      // Emulate a tap on the last product.
      await tester.tap(lastProduct);

      // Trigger a frame.
      await tester.pumpAndSettle();

      expect(find.byType(ItemPage), findsOneWidget);
      // Content of last product
      expect(find.text("Fjallraven"), findsNothing);

      // Emulate a tap on the back button.
      await tester.tap(back);

      // Trigger a frame.
      await tester.pumpAndSettle();
      // Content of listview page
      expect(find.byType(ItemPage), findsNothing);
    });
  });
}
