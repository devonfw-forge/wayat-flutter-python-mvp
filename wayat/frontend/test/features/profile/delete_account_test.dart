import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/features/profile/pages/delete_account_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'profile_test.mocks.dart';

@GenerateMocks([SessionState, ProfileState])
void main() async {
  final MockSessionState mockSessionState = MockSessionState();
  final MockProfileState mockProfileState = MockProfileState();

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    HttpOverrides.global = null;
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<ProfileState>(mockProfileState);
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

  group("Delete account page has correct components", () {
    testWidgets('Delete account title', (tester) async {
      await tester.pumpWidget(_createApp(DeleteAccountPage()));
      expect(find.widgetWithText(AlertDialog, appLocalizations.deleteAccount),
          findsOneWidget);
    });

    testWidgets('Delete account text', (tester) async {
      await tester.pumpWidget(_createApp(DeleteAccountPage()));
      expect(find.text(appLocalizations.deleteAccountText), findsOneWidget);
    });

    testWidgets('Veryfi and Cancel buttons is correct', (tester) async {
      await tester.pumpWidget(_createApp(DeleteAccountPage()));
      expect(find.byType(CustomFilledButton), findsOneWidget);
    });
  });
}
