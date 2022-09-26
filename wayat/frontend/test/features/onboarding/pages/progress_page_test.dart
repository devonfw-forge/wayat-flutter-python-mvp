import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/pages/progress_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'progress_page_test.mocks.dart';

@GenerateMocks([
  SessionState,
  OnboardingController
])
void main() {
  late OnboardingController controller;

  setUpAll(() {
    GetIt.I.registerSingleton<SessionState>(MockSessionState());
    GetIt.I.registerSingleton<OnboardingController>(MockOnboardingController());
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    controller = GetIt.I.get<OnboardingController>();
    when(controller.currentPage).thenReturn(OnBoardingProgress.initialManageContactsTip);
    when(controller.moveBack()).thenAnswer((_) => false);
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

  testWidgets('Onboarding has a skip button', (tester) async {
    await tester.pumpWidget(createApp(ProgressOnboardingPage()));
    expect(find.text(appLocalizations.skip), findsOneWidget);
  });

  // testWidgets('OnBoarding skip function', (tester) async {
  //   await tester.pumpWidget(createApp(ProgressOnboardingPage()));
  //   await tester.tap(find.byType(IconButton));
  //   await tester.pumpAndSettle();
  //   verify(controller.finishOnBoarding()).called(1);
  // });

  testWidgets('Onboarding has a back button', (tester) async {
    await tester.pumpWidget(createApp(ProgressOnboardingPage()));
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('OnBoarding back function', (tester) async {
    await tester.pumpWidget(createApp(ProgressOnboardingPage()));
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    verify(controller.moveBack()).called(1);
  });
}
