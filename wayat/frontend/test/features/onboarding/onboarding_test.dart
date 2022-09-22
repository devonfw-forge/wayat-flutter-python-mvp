import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_state.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'onboarding_test.mocks.dart';

@GenerateMocks([
  SessionState,
  OnboardingController
], customMocks: [
  MockSpec<SessionState>(
      as: #MockSessionStateRelaxed, onMissingStub: OnMissingStub.returnDefault),
  MockSpec<OnboardingController>(
      as: #MockOnboardingRelaxed, onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late OnboardingController controller;

  setUpAll(() {
    GetIt.I.registerSingleton<SessionState>(MockSessionState());
    GetIt.I.registerSingleton<OnboardingController>(MockOnboardingController());
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    controller = GetIt.I.get<OnboardingController>();
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

  testWidgets('Onboarding has a app title', (tester) async {
    await tester.pumpWidget(createApp(OnBoardingPage()));
    expect(find.text(appLocalizations.appTitle), findsOneWidget);
  });

  testWidgets('Onboarding has a allowed contacts title', (tester) async {
    await tester.pumpWidget(createApp(OnBoardingPage()));
    expect(find.text(appLocalizations.allowedContactsTitle), findsOneWidget);
  });

  testWidgets('Onboarding has a allowed contacts description', (tester) async {
    await tester.pumpWidget(createApp(OnBoardingPage()));
    expect(find.text(appLocalizations.allowedContactsBody), findsOneWidget);
  });

  testWidgets('Onboarding has a next button', (tester) async {
    await tester.pumpWidget(createApp(OnBoardingPage()));
    expect(find.widgetWithText(CustomOutlinedButton, appLocalizations.next),
        findsOneWidget);
  });

  testWidgets('OnBoarding next step', (tester) async {
    await tester.pumpWidget(createApp(OnBoardingPage()));
    await tester.tap(find.byType(CustomOutlinedButton));
    await tester.pumpAndSettle();
    verify(controller.setOnBoardingState(OnBoardingState.current)).called(1);
  });
}
