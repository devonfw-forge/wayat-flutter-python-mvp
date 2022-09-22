import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/buttons/invite_wayat.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mockito/annotations.dart';
import 'package:wayat/services/contact/contact_service.dart';

import 'suggestions_page_test.mocks.dart';

@GenerateMocks([
  ContactsPageController,
  SuggestionsController,
  ContactService,
  FriendsController,
  RequestsController
])
void main() async {
  final SuggestionsController mockSuggestionsController =
      MockSuggestionsController();
  final ContactsPageController mockContactsPageController =
      MockContactsPageController();

  setUpAll(() {
    HttpOverrides.global = null;
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<SuggestionsController>(mockSuggestionsController);

    when(mockContactsPageController.suggestionsController)
        .thenReturn(mockSuggestionsController);
    when(mockSuggestionsController.updateSuggestedContacts())
        .thenAnswer((_) => Future.value([]));
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

  group("Invitation button", () {
    testWidgets('Suggestions page has a invitation button', (tester) async {
      when(mockSuggestionsController.updateSuggestedContacts())
          .thenAnswer((_) => Future.value([]));
      when(mockSuggestionsController.filteredSuggestions)
          .thenReturn(mobx.ObservableList<Contact>.of([]));

      await tester.pumpWidget(createApp(SuggestionsPage()));
      expect(
          find.widgetWithText(
              CustomInviteWayat, appLocalizations.inviteContacts),
          findsOneWidget);
    });

    testWidgets('Invitation button copies a text', (tester) async {
      when(mockSuggestionsController.filteredSuggestions)
          .thenReturn(mobx.ObservableList<Contact>.of([]));
      when(mockSuggestionsController.copyInvitation())
          .thenAnswer((_) => Future.value(null));

      await tester.pumpWidget(createApp(SuggestionsPage()));

      await tester.tap(find.byType(TextButton));
      verify(mockSuggestionsController.copyInvitation()).called(1);
    });
  });

  testWidgets("Suggestions page title is correct", (tester) async {
    await tester.pumpWidget(createApp(SuggestionsPage()));
    await tester.pumpAndSettle();

    expect(find.text(appLocalizations.suggestionsPageTitle), findsOneWidget);
  });

  testWidgets("The suggestions list shows the correct number of contacts",
      (tester) async {
    when(mockSuggestionsController.filteredSuggestions)
        .thenReturn(mobx.ObservableList.of(mobx.ObservableList.of([])));

    await tester.pumpWidget(createApp(SuggestionsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNothing);

    when(mockSuggestionsController.filteredSuggestions).thenReturn(
        mobx.ObservableList.of(_generateContacts(["TestA", "TestB", "TestC"])));

    await tester.pumpWidget(createApp(SuggestionsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNWidgets(3));
  });

  testWidgets("Tapping on the contact tile icon sends a friend request",
      (tester) async {
    final Contact contact = _contactFactory("TestA");
    when(mockSuggestionsController.filteredSuggestions)
        .thenReturn(mobx.ObservableList.of([contact]));
    when(mockSuggestionsController.sendRequest(contact))
        .thenAnswer((_) => Future.value(null));

    await tester.pumpWidget(createApp(SuggestionsPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();

    verify(mockSuggestionsController.sendRequest(contact)).called(1);
  });

  testWidgets("Sending a friend request removes the suggestion tile",
      (tester) async {
    final Contact contact = _contactFactory("TestA");
    ContactService mockContactService = MockContactService();
    SuggestionsController suggestionsController = SuggestionsController(
        friendsController: MockFriendsController(),
        requestsController: MockRequestsController(),
        contactsService: mockContactService);
    suggestionsController.filteredSuggestions =
        mobx.ObservableList.of([contact]);
    when(mockContactsPageController.suggestionsController)
        .thenReturn(suggestionsController);

    await tester.pumpWidget(createApp(SuggestionsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNothing);
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

List<Contact> _generateContacts(List<String> names) {
  return names.map((name) => _contactFactory(name)).toList();
}
