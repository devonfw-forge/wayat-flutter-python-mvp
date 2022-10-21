import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_state.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/lang/app_localizations.dart';

import '../../../test_common/test_app.dart';
import 'onboarding_test.mocks.dart';

@GenerateMocks([UserState, OnboardingController])
void main() {
  final MockOnboardingController controller = MockOnboardingController();

  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(MockUserState());
    GetIt.I.registerSingleton<OnboardingController>(controller);
  });

  testWidgets('Onboarding has a app title', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: OnBoardingPage()));
    expect(find.text(appLocalizations.appTitle), findsOneWidget);
  });

  testWidgets('Onboarding has a allowed contacts title', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: OnBoardingPage()));
    expect(find.text(appLocalizations.allowedContactsTitle), findsOneWidget);
  });

  testWidgets('Onboarding has a allowed contacts description', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: OnBoardingPage()));
    expect(find.text(appLocalizations.allowedContactsBody), findsOneWidget);
  });

  testWidgets('Onboarding has a next button', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: OnBoardingPage()));
    expect(find.widgetWithText(CustomOutlinedButton, appLocalizations.next),
        findsOneWidget);
  });

  testWidgets('OnBoarding next step', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: OnBoardingPage()));
    await tester.tap(find.byType(CustomOutlinedButton));
    await tester.pumpAndSettle();
    verify(controller.setOnBoardingState(OnBoardingState.current)).called(1);
  });
}
