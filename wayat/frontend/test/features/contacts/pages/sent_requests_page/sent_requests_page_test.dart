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
import 'package:wayat/features/contacts/pages/sent_requests_page/sent_requests_page.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/friend_requests/requests_service.dart';
import 'package:mobx/mobx.dart' as mobx;

import '../../../../test_common/test_app.dart';
import 'sent_requests_page_test.mocks.dart';

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

    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    when(mockContactsPageController.requestsController)
        .thenReturn(mockRequestsController);
    when(mockRequestsController.sentRequests)
        .thenReturn(mobx.ObservableList.of([]));
  });

  testWidgets("Sent requests header is correct", (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: SentRequestsPage()));
    await tester.pumpAndSettle();

    expect(find.text(appLocalizations.sentRequestsTitle), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
  });

  testWidgets("Sent requests tiles are displayed correctly", (tester) async {
    when(mockRequestsController.sentRequests)
        .thenReturn(mobx.ObservableList.of(_generateContacts(["TestA"])));
    await tester.pumpWidget(TestApp.createApp(body: SentRequestsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsOneWidget);
    expect(find.widgetWithText(ContactTile, appLocalizations.sentButtonTile),
        findsOneWidget);
    expect(find.widgetWithIcon(ContactTile, Icons.close), findsOneWidget);
  });

  testWidgets("The number of requests tiles is correct", (tester) async {
    when(mockRequestsController.sentRequests)
        .thenReturn(mobx.ObservableList.of(_generateContacts([])));
    await tester.pumpWidget(TestApp.createApp(body: SentRequestsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNothing);

    when(mockRequestsController.sentRequests).thenReturn(
        mobx.ObservableList.of(_generateContacts(["TestA", "TestB", "TestC"])));
    await tester.pumpWidget(TestApp.createApp(body: SentRequestsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNWidgets(3));
  });

  testWidgets("Tapping in the close icon should unsend the request",
      (tester) async {
    Contact contact = _contactFactory("TestA");
    when(mockRequestsController.sentRequests)
        .thenReturn(mobx.ObservableList.of([contact]));
    when(mockRequestsController.unsendRequest(contact))
        .thenAnswer((_) => Future.value(null));

    await tester.pumpWidget(TestApp.createApp(body: SentRequestsPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithIcon(IconButton, Icons.close));
    await tester.pumpAndSettle();

    verify(mockRequestsController.unsendRequest(contact)).called(1);
  });

  testWidgets("Unsending the request should remove the request tile",
      (tester) async {
    Contact contact = _contactFactory("TestA");
    RequestsService mockRequestsService = MockRequestsService();
    RequestsController requestsController = RequestsController(
        friendsController: MockFriendsController(),
        requestsService: mockRequestsService);
    when(mockRequestsService.cancelRequest(contact))
        .thenAnswer((_) => Future.value(true));
    when(mockContactsPageController.requestsController)
        .thenReturn(requestsController);

    requestsController.sentRequests = mobx.ObservableList.of([contact]);

    await tester.pumpWidget(TestApp.createApp(body: SentRequestsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsOneWidget);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.close));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNothing);
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

List<Contact> _generateContacts(List<String> names) {
  return names.map((name) => _contactFactory(name)).toList();
}
