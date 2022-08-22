import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_page_test.mocks.dart';


@GenerateMocks([SessionState], customMocks: [MockSpec<SessionState>(as: #MockSessionStateRelaxed, onMissingStub: OnMissingStub.returnDefault)])
void main() async {

  late SessionState userSession;

  setUpAll(() {
    GetIt.I.registerSingleton<SessionState>(MockSessionState());
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    userSession = GetIt.I.get<SessionState>();
  });

  Widget _createApp (Widget body) {
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


  testWidgets('Login page has a app title', (tester) async {
    await tester.pumpWidget(_createApp(const LoginPage()));
    expect(find.widgetWithText(CustomWayatTitle, appLocalizations.appTitle), findsOneWidget);
  });


  testWidgets('Login page has a login title', (tester) async {
    await tester.pumpWidget(_createApp(const LoginPage()));
    expect(find.widgetWithText(CustomLoginTitle,appLocalizations.login), findsOneWidget);
  });

  testWidgets('Login page has a sign in button', (tester) async {
    await tester.pumpWidget(_createApp(const LoginPage()));
    expect(find.byType(InkWell), findsOneWidget);
  });

  // testWidgets('Login submit button changes session state', (tester) async {
  //   await tester.pumpWidget(_createApp(const LoginPage()));
  //   await tester.tap(find.byType(InkWell));
  //   await tester.pumpAndSettle();
  //   verify(await userSession.login()).called(1);
  // });

}
