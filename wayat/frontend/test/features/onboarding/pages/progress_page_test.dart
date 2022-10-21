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

import '../../../test_common/test_app.dart';
import 'progress_page_test.mocks.dart';

@GenerateMocks([UserState, OnboardingController])
void main() {
  MockOnboardingController controller = MockOnboardingController();

  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(MockUserState());
    GetIt.I.registerSingleton<OnboardingController>(controller);
    when(controller.currentPage)
        .thenReturn(OnBoardingProgress.initialManageContactsTip);
    when(controller.moveBack()).thenAnswer((_) => false);
    when(controller.finishOnBoarding()).thenReturn(null);
  });

  testWidgets('Onboarding has a skip button', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ProgressOnboardingPage()));
    expect(find.text(appLocalizations.skip), findsOneWidget);
  });

  testWidgets('OnBoarding skip function', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ProgressOnboardingPage()));
    await tester.tap(find.text(appLocalizations.skip));
    await tester.pumpAndSettle();
    verify(controller.finishOnBoarding()).called(1);
  });

  testWidgets('Onboarding has a back button', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ProgressOnboardingPage()));
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('OnBoarding back function', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ProgressOnboardingPage()));
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    verify(controller.moveBack()).called(1);
  });
}
