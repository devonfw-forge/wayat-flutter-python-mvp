import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/widgets/selected_contacts.dart';
import 'package:mockito/annotations.dart';

import '../../../test_common/test_app.dart';
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
  });

  testWidgets('SelectedContacts has a CustomTextIconButton', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: SelectedContacts()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(CustomTextIconButton), findsOneWidget);
  });

  testWidgets('SelectedContacts has a CustomOutlinedButton', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: SelectedContacts()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(CustomOutlinedButton), findsOneWidget);
  });

  testWidgets('Tap on CustomTextIconButton moves back', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: SelectedContacts()));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.byType(CustomTextIconButton));
    await tester.pumpAndSettle();
    verify(controller.moveBack()).called(1);
  });

  testWidgets('Tap on CustomOutlinedButton moves back', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: SelectedContacts()));
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
