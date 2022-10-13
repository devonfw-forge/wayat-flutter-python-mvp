import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/notification_state/notification_state.dart';
import 'package:wayat/domain/notification/push_notification.dart';
import 'package:wayat/features/notification/page/notification_page.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'notification_page_test.mocks.dart';

@GenerateMocks([NotificationState])
void main() async {
  final MockNotificationState mockNotificationState = MockNotificationState();

  setUpAll(() {
    GetIt.I.registerSingleton<NotificationState>(mockNotificationState);
    when(mockNotificationState.notificationInfo).thenReturn(PushNotification(
        title: 'Test Notification Title',
        body: 'Test Notification Body',
        dataTitle: 'Test Notification dataTitle',
        dataBody: 'Test Notification dataBody'));
    when(mockNotificationState.totalNotifications).thenReturn(2);

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

  // testWidgets('Notification page has correct components', (tester) async {
  //   await tester.pumpWidget(createApp(const NotificationPage()));
  //   await tester.pump(const Duration(seconds: 1));
  //   expect(
  //       find.text(
  //           'TITLE: ${mockNotificationState.notificationInfo!.title ?? mockNotificationState.notificationInfo!.body}'),
  //       findsOneWidget);
  //   expect(
  //       find.text(
  //           'BODY: ${mockNotificationState.notificationInfo!.dataTitle ?? mockNotificationState.notificationInfo!.dataBody}'),
  //       findsOneWidget);
  // });
}
