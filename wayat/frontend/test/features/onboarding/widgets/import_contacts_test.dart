import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/contact_tile.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/import_contacts_list.dart';
import 'package:mockito/annotations.dart';

import '../../../test_common/test_app.dart';
import 'selected_contacts_test.mocks.dart';

@GenerateMocks([OnboardingController])
void main() async {
  late OnboardingController controller;

  Contact contact = _contactFactory('ContactA');

  setUpAll(() async {
    HttpOverrides.global = null;
    controller = MockOnboardingController();
    when(controller.contactList).thenAnswer((_) => [contact]);
    when(controller.isSelected(contact)).thenAnswer((_) => false);
    when(controller.updateSelected(contact))
        // ignore: avoid_returning_null_for_void
        .thenAnswer((_) => null);
    when(controller.isSelected(contact)).thenAnswer((_) => false);
    when(controller.updateSelected(contact))
        // ignore: avoid_returning_null_for_void
        .thenAnswer((_) => null);
    when(controller.progressTo(OnBoardingProgress.sendRequests))
        // ignore: avoid_returning_null_for_void
        .thenAnswer((_) => null);
    GetIt.I.registerSingleton<OnboardingController>(controller);
  });

  testWidgets('ImportedContactsList has a ContactTile', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ImportedContactsList()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(ContactTile), findsOneWidget);
  });

  testWidgets('ImportedContactsList has a list of AzListView', (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ImportedContactsList()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(AzListView), findsOneWidget);
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
