import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/requests_page/requests_page.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:wayat/services/friend_requests/requests_service.dart';

import 'requests_page_test.mocks.dart';

@GenerateMocks([
  ContactsPageController,
  RequestsController,
  RequestsService,
  FriendsController
])
void main() async {
  final RequestsController mockRequestsController = MockRequestsController();
  final ContactsPageController mockContactsPageController =
      MockContactsPageController();

  setUpAll(() {
    HttpOverrides.global = null;

    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    when(mockContactsPageController.requestsController)
        .thenReturn(mockRequestsController);
  });

  Widget _createApp(Widget body) {
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

  testWidgets("Request tiles are correctly built", (tester) async {
    when(mockRequestsController.filteredPendingRequests)
        .thenReturn(mobx.ObservableList.of(_generateContacts(["A"])));

    await tester.pumpWidget(_createApp(RequestsPage()));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ContactTile, appLocalizations.accept),
        findsOneWidget);
    expect(find.widgetWithIcon(ContactTile, Icons.close), findsOneWidget);
  });

  testWidgets("Requests page title shows the correct number of requests",
      (tester) async {
    when(mockRequestsController.filteredPendingRequests)
        .thenReturn(mobx.ObservableList.of([]));

    await tester.pumpWidget(_createApp(RequestsPage()));
    await tester.pumpAndSettle();

    expect(find.text("${appLocalizations.pendingRequestsTitle} (0)"),
        findsOneWidget);

    when(mockRequestsController.filteredPendingRequests)
        .thenReturn(mobx.ObservableList.of(_generateContacts(["A", "B", "C"])));

    await tester.pumpWidget(_createApp(RequestsPage()));
    await tester.pumpAndSettle();

    expect(find.text("${appLocalizations.pendingRequestsTitle} (3)"),
        findsOneWidget);
  });

  testWidgets("There is a sent button that redirects to sent requests",
      (tester) async {
    when(mockRequestsController.filteredPendingRequests)
        .thenReturn(mobx.ObservableList.of([]));
    when(mockContactsPageController.setviewSentRequests(true))
        .thenAnswer((_) => Future.value(null));

    await tester.pumpWidget(_createApp(RequestsPage()));
    await tester.pumpAndSettle();

    expect(find.text(appLocalizations.sentButtonNavigation), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);

    await tester.tap(find.text(appLocalizations.sentButtonNavigation));

    verify(mockContactsPageController.setviewSentRequests(true)).called(1);
  });

  testWidgets("Tapping Accept in a contact tile accepts the request",
      (tester) async {
    Contact contact = _contactFactory("TestA");
    when(mockRequestsController.filteredPendingRequests)
        .thenReturn(mobx.ObservableList.of([contact]));
    when(mockRequestsController.acceptRequest(contact))
        .thenAnswer((_) => Future.value(null));

    await tester.pumpWidget(_createApp(RequestsPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, appLocalizations.accept));

    verify(mockRequestsController.acceptRequest(contact)).called(1);
  });

  testWidgets("Tapping the close icon in a contact tile rejects the request",
      (tester) async {
    Contact contact = _contactFactory("TestA");
    when(mockRequestsController.filteredPendingRequests)
        .thenReturn(mobx.ObservableList.of([contact]));
    when(mockRequestsController.rejectRequest(contact))
        .thenAnswer((_) => Future.value(null));

    await tester.pumpWidget(_createApp(RequestsPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithIcon(IconButton, Icons.close));

    verify(mockRequestsController.rejectRequest(contact)).called(1);
  });

  testWidgets("Tapping Accept in a contact tile removes the request",
      (tester) async {
    RequestsService mockRequestsService = MockRequestsService();
    RequestsController requestsController = RequestsController(
        friendsController: MockFriendsController(),
        requestsService: mockRequestsService);
    Contact contact = _contactFactory("TestA");
    requestsController.filteredPendingRequests =
        mobx.ObservableList.of([contact]);
    when(mockContactsPageController.requestsController)
        .thenReturn(requestsController);
    when(mockRequestsService.acceptRequest(contact))
        .thenAnswer((realInvocation) => Future.value(true));

    await tester.pumpWidget(_createApp(RequestsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, appLocalizations.accept));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNothing);
  });

  testWidgets("Tapping the close icon in a contact tile removes the request",
      (tester) async {
    RequestsService mockRequestsService = MockRequestsService();
    RequestsController requestsController = RequestsController(
        friendsController: MockFriendsController(),
        requestsService: mockRequestsService);
    Contact contact = _contactFactory("TestA");
    requestsController.filteredPendingRequests =
        mobx.ObservableList.of([contact]);
    when(mockContactsPageController.requestsController)
        .thenReturn(requestsController);
    when(mockRequestsService.rejectRequest(contact))
        .thenAnswer((realInvocation) => Future.value(true));

    await tester.pumpWidget(_createApp(RequestsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsOneWidget);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.close));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNothing);
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    available: true,
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
