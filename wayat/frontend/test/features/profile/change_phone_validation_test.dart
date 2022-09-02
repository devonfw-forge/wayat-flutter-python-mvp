import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/common/widgets/buttons/text_button.dart';
import 'package:wayat/common/widgets/card.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/pages/change_phone_page/change_phone_validation_page.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'profile_test.mocks.dart';

@GenerateMocks([SessionState, ProfileState, LocationState])
void main() async {
  final MockSessionState mockSessionState = MockSessionState();
  final MockProfileState mockProfileState = MockProfileState();
  final MockLocationState mockLocationState = MockLocationState();
  late MyUser user;

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    HttpOverrides.global = null;
    user = MyUser(
        id: "5",
        name: "test",
        email: "test@capg.com",
        imageUrl: "http://example.com",
        phone: "123456789",
        onboardingCompleted: true,
        shareLocationEnabled: true);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    when(mockSessionState.currentUser).thenAnswer((_) => user);
    GetIt.I.registerSingleton<ProfileState>(mockProfileState);
    GetIt.I.registerSingleton<LocationState>(mockLocationState);
    when(mockLocationState.shareLocationEnabled).thenAnswer((_) => false);
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

  group("Change phone validation page has correct components", () {
    testWidgets('Change phone validation page title', (tester) async {
      await tester.pumpWidget(_createApp(ChangePhoneValidationPage(
        newPhoneNumber: '+34777777777',
      )));
      expect(find.widgetWithText(Text, appLocalizations.verifyPhoneTitle),
          findsOneWidget);
    });

    testWidgets('Change phone validation page text', (tester) async {
      await tester.pumpWidget(_createApp(ChangePhoneValidationPage(
        newPhoneNumber: '+34888888888',
      )));
      expect(find.widgetWithText(Text, appLocalizations.verifyPhoneText),
          findsOneWidget);
    });

    testWidgets('Change phone validation page Verify button', (tester) async {
      await tester.pumpWidget(_createApp(ChangePhoneValidationPage(
        newPhoneNumber: '+34999999999',
      )));
      expect(find.byType(CustomFilledButton), findsOneWidget);
    });

    testWidgets('Change phone validation page Cancel button', (tester) async {
      await tester.pumpWidget(_createApp(ChangePhoneValidationPage(
        newPhoneNumber: '+34000000000',
      )));
      expect(find.byType(CustomTextButton), findsOneWidget);
    });
  });
}
