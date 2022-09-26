import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/contact_item.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/contact_tile.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/import_contacts_list.dart';
import 'package:wayat/features/onboarding/widgets/selected_contacts.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'selected_contacts_test.mocks.dart';

@GenerateMocks([
  OnboardingController
])

void main() async {
  late OnboardingController controller;
  
  Contact contact = _contactFactory('ContactA');

  setUpAll(() async {
    HttpOverrides.global = null;
    controller = MockOnboardingController();
    when(controller.contactList)
      .thenAnswer((_) => [contact]);
    when(controller.isSelected(contact))
      .thenAnswer((_) => false);
    when(controller.updateSelected(contact))
      // ignore: avoid_returning_null_for_void
      .thenAnswer((_) => null);
    when(controller.isSelected(contact))
      .thenAnswer((_) => false);
    when(controller.updateSelected(contact))
      // ignore: avoid_returning_null_for_void
      .thenAnswer((_) => null);
    when(controller.progressTo(OnBoardingProgress.sendRequests))
      // ignore: avoid_returning_null_for_void
      .thenAnswer((_) => null);
    GetIt.I.registerSingleton<OnboardingController>(controller);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
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

  testWidgets('ImportedContactsList has a ContactTile',
      (tester) async {
    await tester.pumpWidget(createApp(ImportedContactsList()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(ContactTile), findsOneWidget);
  });

  testWidgets('ImportedContactsList has a list of AzListView',
      (tester) async {
    await tester.pumpWidget(createApp(ImportedContactsList()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(AzListView), findsOneWidget);
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    available: true,
    shareLocation: true,
    id: "id $contactName",
    name: contactName,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
  );
}
