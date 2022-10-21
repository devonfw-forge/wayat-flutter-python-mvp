import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/features/profile/widgets/restart_ios_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';

import '../../../test_common/test_app.dart';

void main() async {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  testWidgets('Restart info dialog is correct', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: const RestartIosDialog()));
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Restart info dialoghas a correct title', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: const RestartIosDialog()));
    expect(find.text(appLocalizations.iosChangeLangTitle), findsOneWidget);
  });

  testWidgets('Restart info dialog has a correct text', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: const RestartIosDialog()));
    expect(find.text(appLocalizations.iosChangeLangMsg), findsOneWidget);
  });

  testWidgets('Restart info dialog has button Ok', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: const RestartIosDialog()));
    expect(find.byType(CustomFilledButton), findsOneWidget);
    expect(find.text('Ok'), findsOneWidget);
  });
}
