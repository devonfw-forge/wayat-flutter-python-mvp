import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/app_state/location_state/receive_location/receive_location_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/friends_page/friends_page.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:wayat/services/contact/contact_service.dart';

import 'friends_page_test.mocks.dart';

@GenerateMocks([
  ContactsPageController,
  FriendsController,
  HomeNavState,
  ContactService,
  LocationListener,
  ReceiveLocationState
])
void main() async {
  final FriendsController mockFriendsController = MockFriendsController();
  final ContactsPageController mockContactsPageController =
      MockContactsPageController();
  final HomeNavState mockHomeState = MockHomeNavState();
  final ReceiveLocationState mockReceiveLocationState =
      MockReceiveLocationState();
  final MockLocationListener mockLocationListener = MockLocationListener();

  setUpAll(() {
    HttpOverrides.global = null;

    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<HomeNavState>(mockHomeState);
    GetIt.I.registerSingleton<LocationListener>(mockLocationListener);
    when(mockLocationListener.receiveLocationState)
        .thenReturn(mockReceiveLocationState);
    when(mockReceiveLocationState.contacts).thenReturn([]);
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
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

  testWidgets("Friends page title shows the correct number of contacts",
      (tester) async {
    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([]));

    await tester.pumpWidget(createApp(FriendsPage()));
    await tester.pumpAndSettle();

    expect(
        find.text("${appLocalizations.friendsPageTitle} (0)"), findsOneWidget);

    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of(_generateContacts(["A", "B", "C"])));

    await tester.pumpWidget(createApp(FriendsPage()));
    await tester.pumpAndSettle();

    expect(
        find.text("${appLocalizations.friendsPageTitle} (3)"), findsOneWidget);
  });

  testWidgets("Friends Page shows the button to navigate to groups",
      (tester) async {
    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([]));

    await tester.pumpWidget(createApp(FriendsPage()));
    await tester.pumpAndSettle();

    expect(
        find.ancestor(
            of: find.byIcon(Icons.chevron_right),
            matching: find.byType(InkWell)),
        findsOneWidget);
    expect(
        find.ancestor(
            of: find.text(appLocalizations.groupsTitle),
            matching: find.byType(InkWell)),
        findsOneWidget);
  });

  testWidgets("The friends list shows the correct number of contacts",
      (tester) async {
    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([]));

    await tester.pumpWidget(createApp(FriendsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNothing);

    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of(_generateContacts(["A", "B", "C"])));

    await tester.pumpWidget(createApp(FriendsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsNWidgets(3));

    expect(
        find.text("${appLocalizations.friendsPageTitle} (3)"), findsOneWidget);
  });

  testWidgets("Tapping a contact tile tries to navigate to ContactProfile",
      (tester) async {
    Contact contact = _contactFactory("A");
    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([contact]));

    await tester.pumpWidget(createApp(FriendsPage()));

    when(mockHomeState.setSelectedContact(contact)).thenReturn(null);

    await tester.pumpAndSettle();

    await tester.tap(find.byType(ContactTile));
    await tester.pumpAndSettle();

    verify(mockHomeState.setSelectedContact(contact)).called(1);
  });

  testWidgets("Tapping the icon in ContactTile removes the contact",
      (tester) async {
    Contact contact = _contactFactory("A");
    ContactService mockContactService = MockContactService();
    when(mockContactService.removeContact(contact))
        .thenAnswer((_) => Future.value(true));
    FriendsController friendsController =
        FriendsController(contactService: mockContactService);
    friendsController.allContacts = mobx.ObservableList.of([contact]);
    friendsController.filteredContacts = mobx.ObservableList.of([contact]);

    when(mockContactsPageController.friendsController)
        .thenReturn(friendsController);

    await tester.pumpWidget(createApp(FriendsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(ContactTile), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
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
