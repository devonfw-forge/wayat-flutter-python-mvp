import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:mockito/annotations.dart';

import '../../test_common/test_app.dart';
import 'login_page_test.mocks.dart';

@GenerateMocks([UserState])
void main() async {
  final UserState userState = MockUserState();

  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(userState);
  });

  group('Login page has the correct widgets', () {
    testWidgets('Login page has a app title', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: const LoginPage()));
      expect(find.widgetWithText(CustomWayatTitle, appLocalizations.appTitle),
          findsOneWidget);
    });

    testWidgets('Login page has a login title', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: const LoginPage()));
      expect(find.widgetWithText(CustomLoginTitle, appLocalizations.login),
          findsOneWidget);
    });

    testWidgets('Login page has a sign in button', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: const LoginPage()));
      expect(find.byType(InkWell), findsOneWidget);
    });
  });

  testWidgets('Login submit button changes session state', (tester) async {
    when(userState.login()).thenAnswer((_) => Future<void>.value());
    when(userState.currentUser).thenReturn(null);

    await tester.pumpWidget(TestApp.createApp(body: const LoginPage()));
    await tester.tap(find.text(appLocalizations.loginGoogle));
    await tester.pumpAndSettle();
    verify(await userState.login()).called(1);
  });
}
