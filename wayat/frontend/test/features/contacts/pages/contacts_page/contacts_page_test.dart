import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/home_state/home_state.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/map_state/map_state.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/common/widgets/search_bar.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:mobx/mobx.dart' as mobx;

import 'contacts_page_test.mocks.dart';

@GenerateMocks([
  ContactsPageController,
  SessionState,
  HomeState,
  LocationState,
  UserStatusState,
  ProfileState,
  MapState,
  FriendsController,
  RequestsController,
  SuggestionsController,
])
void main() async {
  HttpOverrides.global = null;

  final ContactsPageController mockContactsPageController =
      MockContactsPageController();
  final SessionState mockSessionState = MockSessionState();
  final HomeState mockHomeState = MockHomeState();
  final LocationState mockLocationState = MockLocationState();
  final UserStatusState mockUserStatusState = MockUserStatusState();
  final ProfileState mockProfileState = MockProfileState();
  final MapState mockMapState = MockMapState();
  final FriendsController mockFriendsController = MockFriendsController();
  final RequestsController mockRequestsController = MockRequestsController();
  final SuggestionsController mockSuggestionsController =
      MockSuggestionsController();

  setUpAll(() {
    when(mockContactsPageController.searchBarController)
        .thenReturn(TextEditingController());
    when(mockSessionState.finishLoggedIn).thenReturn(true);
    when(mockSessionState.hasDoneOnboarding).thenReturn(true);
    when(mockHomeState.selectedContact).thenReturn(null);
    when(mockLocationState.initialize()).thenAnswer((_) => Future.value(null));
    when(mockLocationState.currentLocation).thenReturn(const LatLng(1, 1));
    when(mockLocationState.shareLocationEnabled).thenReturn(false);
    when(mockContactsPageController.viewSentRequests).thenReturn(false);
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
    when(mockContactsPageController.requestsController)
        .thenReturn(mockRequestsController);
    when(mockContactsPageController.suggestionsController)
        .thenReturn(mockSuggestionsController);
    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([]));
    when(mockUserStatusState.contacts).thenReturn([]);

    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<HomeState>(mockHomeState);
    GetIt.I.registerSingleton<LocationState>(mockLocationState);
    GetIt.I.registerSingleton<UserStatusState>(mockUserStatusState);
    GetIt.I.registerSingleton<ProfileState>(mockProfileState);
    GetIt.I.registerSingleton<MapState>(mockMapState);
  });

  Widget _createApp() {
    final appRouter = AppRouter();

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }

  Future navigateToContactsPage(WidgetTester tester) async {
    await tester.pumpWidget(_createApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.contacts_outlined));
    await tester.pumpAndSettle();
  }

  testWidgets("The search bar appears correctly", (tester) async {
    await navigateToContactsPage(tester);
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
    await navigateToContactsPage(tester);

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
    await navigateToContactsPage(tester);
    await tester.enterText(find.byKey(searchBarKey), "Input");
    verify(mockContactsPageController.setSearchBarText("Input")).called(1);
  });
}
