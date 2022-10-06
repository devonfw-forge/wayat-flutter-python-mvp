import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/pages/progress_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'progress_page_test.mocks.dart';

@GenerateMocks([UserState, OnboardingController])
void main() {
  MockOnboardingController controller = MockOnboardingController();

  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(MockUserState());
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<OnboardingController>(controller);
    when(controller.currentPage)
        .thenReturn(OnBoardingProgress.initialManageContactsTip);
    when(controller.moveBack()).thenAnswer((_) => false);
    when(controller.finishOnBoarding()).thenReturn(null);
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

  testWidgets('OnBoarding skip function', (tester) async {
    await tester.pumpWidget(createApp(ProgressOnboardingPage()));
    await tester.tap(find.text(appLocalizations.skip));
    await tester.pumpAndSettle();
    verify(controller.finishOnBoarding()).called(1);
  });

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
