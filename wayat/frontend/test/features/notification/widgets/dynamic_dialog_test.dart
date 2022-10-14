import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/notification_state/notification_state.dart';
import 'package:wayat/features/notification/widgets/dynamic_dialog.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../profile/widgets/firebase_mock.dart';
import 'dynamic_dialog_test.mocks.dart';

@GenerateMocks([NotificationState])
void main() async {
  final MockNotificationState mockNotificationState = MockNotificationState();
  setupFirebaseAuthMocks();

  setUpAll(() {
    HttpOverrides.global = null;
    GetIt.I.registerSingleton<NotificationState>(mockNotificationState);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  });

  Widget createApp(Widget body) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('Dynamic dialog is correct', (tester) async {
    await tester.pumpWidget(createApp(const DynamicDialog(
      title: 'Test Notification Title',
      body: 'Test Notification Body',
    )));
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
