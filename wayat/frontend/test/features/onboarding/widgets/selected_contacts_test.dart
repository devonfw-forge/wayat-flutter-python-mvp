import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/widgets/selected_contacts.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'selected_contacts_test.mocks.dart';

@GenerateMocks([OnboardingController])
void main() async {
  late OnboardingController controller;

  Contact contactA = _contactFactory('ContactA');
  Contact contactB = _contactFactory('ContactB');

  setUpAll(() async {
    HttpOverrides.global = null;
    controller = MockOnboardingController();
    when(controller.selectedContacts).thenAnswer((_) => [contactA, contactB]);
    when(controller.moveBack()).thenAnswer((_) => false);
    when(controller.finishOnBoarding())
        // ignore: avoid_returning_null_for_void
        .thenAnswer((_) => null);
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

  testWidgets('SelectedContacts has a CustomTextIconButton', (tester) async {
    await tester.pumpWidget(createApp(SelectedContacts()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(CustomTextIconButton), findsOneWidget);
  });

  testWidgets('SelectedContacts has a CustomOutlinedButton', (tester) async {
    await tester.pumpWidget(createApp(SelectedContacts()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(CustomOutlinedButton), findsOneWidget);
  });

  testWidgets('Tap on CustomTextIconButton moves back', (tester) async {
    await tester.pumpWidget(createApp(SelectedContacts()));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byType(CustomTextIconButton));
    await tester.pumpAndSettle();
    verify(controller.moveBack()).called(1);
  });

  testWidgets('Tap on CustomOutlinedButton moves back', (tester) async {
    await tester.pumpWidget(createApp(SelectedContacts()));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byType(CustomOutlinedButton));
    await tester.pumpAndSettle();
    verify(controller.finishOnBoarding()).called(1);
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    shareLocationTo: true,
    id: "id $contactName",
    name: contactName,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
  );
}
