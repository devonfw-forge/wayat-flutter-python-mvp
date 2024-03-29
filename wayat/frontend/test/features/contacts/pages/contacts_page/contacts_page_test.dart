import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/features/contacts/pages/contacts_page/contacts_page.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/app_state/location_state/receive_location/receive_location_state.dart';
import 'package:mobx/mobx.dart' as mobx;

import '../../../../test_common/test_app.dart';
import 'contacts_page_test.mocks.dart';

@GenerateMocks([
  ContactsPageController,
  UserState,
  HomeNavState,
  ShareLocationState,
  ReceiveLocationState,
  LocationListener,
  LifeCycleState,
  FriendsController,
  RequestsController,
  SuggestionsController,
  GroupsController,
])
void main() async {
  HttpOverrides.global = null;

  final ContactsPageController mockContactsPageController =
      MockContactsPageController();
  final MockUserState mockUserState = MockUserState();
  final MockHomeNavState mockHomeState = MockHomeNavState();
  final MockShareLocationState mockLocationState = MockShareLocationState();
  final MockReceiveLocationState mockReceiveLocationState =
      MockReceiveLocationState();
  final MockLocationListener mockLocationListener = MockLocationListener();
  final MockLifeCycleState mockMapState = MockLifeCycleState();
  final MockFriendsController mockFriendsController = MockFriendsController();
  final MockRequestsController mockRequestsController =
      MockRequestsController();
  final MockSuggestionsController mockSuggestionsController =
      MockSuggestionsController();
  final MockGroupsController mockGroupsController = MockGroupsController();

  setUpAll(() {
    when(mockContactsPageController.searchBarController)
        .thenReturn(TextEditingController());
    when(mockHomeState.selectedContact).thenReturn(null);
    when(mockLocationState.initialize()).thenAnswer((_) => Future.value(null));
    when(mockLocationState.currentLocation).thenReturn(const LatLng(1, 1));
    when(mockLocationState.shareLocationEnabled).thenReturn(false);
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
    when(mockContactsPageController.requestsController)
        .thenReturn(mockRequestsController);
    when(mockContactsPageController.suggestionsController)
        .thenReturn(mockSuggestionsController);
    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([]));
    when(mockLocationListener.receiveLocationState)
        .thenReturn(mockReceiveLocationState);
    when(mockLocationListener.shareLocationState).thenReturn(mockLocationState);
    when(mockReceiveLocationState.contacts).thenReturn([]);
    when(mockGroupsController.updateGroups())
        .thenAnswer((_) => Future.value(true));
    when(mockGroupsController.groups)
        .thenAnswer((_) => <Group>[].asObservable());

    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<UserState>(mockUserState);
    GetIt.I.registerSingleton<HomeNavState>(mockHomeState);
    GetIt.I.registerSingleton<ShareLocationState>(mockLocationState);
    GetIt.I.registerSingleton<LocationListener>(mockLocationListener);
    GetIt.I.registerSingleton<LifeCycleState>(mockMapState);
    GetIt.I.registerSingleton<GroupsController>(mockGroupsController);
  });

  testWidgets("The search bar appears correctly", (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ContactsPage("friends")));
    const Key searchBarKey = Key("ContactsSearchBar");

    expect(find.byKey(searchBarKey), findsOneWidget);
    expect(
        find.descendant(
            of: find.byKey(searchBarKey),
            matching: find.text(appLocalizations.search)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byKey(searchBarKey), matching: find.byIcon(Icons.search)),
        findsOneWidget);
  });

  testWidgets("The tab bar appears correctly", (tester) async {
    await tester.pumpWidget(TestApp.createApp(body: ContactsPage("friends")));

    expect(find.byType(TabBar), findsOneWidget);
    expect(find.byType(Tab), findsNWidgets(3));
    expect(
        find.descendant(
            of: find.byType(Tab),
            matching: find.text(appLocalizations.friendsTab)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(Tab),
            matching: find.text(appLocalizations.requestsTab)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(Tab),
            matching: find.text(appLocalizations.suggestionsTab)),
        findsOneWidget);
  });

  testWidgets("The search bar text changes the controller text",
      (tester) async {
    const Key searchBarKey = Key("ContactsSearchBar");
    when(mockContactsPageController.setSearchBarText("Input")).thenReturn(null);
    await tester.pumpWidget(TestApp.createApp(body: ContactsPage("friends")));
    await tester.enterText(find.byKey(searchBarKey), "Input");
    verify(mockContactsPageController.setSearchBarText("Input")).called(1);
  });
}
