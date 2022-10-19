import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_state.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'onboarding_test.mocks.dart';

@GenerateMocks([UserState, OnboardingController])
void main() {
  final MockOnboardingController controller = MockOnboardingController();

  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(MockUserState());
    GetIt.I.registerSingleton<OnboardingController>(controller);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  });

  Widget createApp(Widget body) {
    final router = GoRouter(initialLocation: "/", routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => Scaffold(
          body: body,
        ),
      ),
    ]);
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      routerConfig: router,
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
