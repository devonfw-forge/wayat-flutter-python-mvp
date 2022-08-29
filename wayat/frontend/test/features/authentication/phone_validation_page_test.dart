import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/common/widgets/components/wayat_title.dart';
import 'package:wayat/features/authentication/common/login_title.dart';
import 'package:wayat/features/authentication/page/phone_validation_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'phone_validation_page_test.mocks.dart';

@GenerateMocks([
  SessionState
], customMocks: [
  MockSpec<SessionState>(
      as: #MockSessionStateRelaxed, onMissingStub: OnMissingStub.returnDefault)
])
void main() async {
  setUpAll(() {
    GetIt.I.registerSingleton<SessionState>(MockSessionState());
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  });

  Widget _createApp(Widget body) {
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

  group('Phone validation page has the correct widgets', () {
    testWidgets('Phone validation page has a app title', (tester) async {
      await tester.pumpWidget(_createApp(const PhoneValidationPage()));
      expect(find.widgetWithText(CustomWayatTitle, appLocalizations.appTitle),
          findsOneWidget);
    });

    testWidgets('Phone validation page has a login title', (tester) async {
      await tester.pumpWidget(_createApp(const PhoneValidationPage()));
      expect(find.widgetWithText(CustomLoginTitle, appLocalizations.login),
          findsOneWidget);
    });

    testWidgets('Phone validation page has a phone description title',
        (tester) async {
      await tester.pumpWidget(_createApp(const PhoneValidationPage()));
      expect(find.text(appLocalizations.phoneNumber), findsWidgets);
    });

    testWidgets('Phone validation page has a phone description',
        (tester) async {
      await tester.pumpWidget(_createApp(const PhoneValidationPage()));
      expect(find.text(appLocalizations.phonePageDescription), findsOneWidget);
    });

    testWidgets('Phone validation page has a phone input field',
        (tester) async {
      await tester.pumpWidget(_createApp(const PhoneValidationPage()));
      expect(find.byType(IntlPhoneField), findsOneWidget);
    });

    testWidgets('Phone validation page has a phone submit button',
        (tester) async {
      await tester.pumpWidget(_createApp(const PhoneValidationPage()));
      expect(find.byType(CustomOutlinedButton), findsOneWidget);
    });
  });
}
