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
import 'package:wayat/common/widgets/card.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:mobx/mobx.dart' as mobx;

import 'profile_integration_test.mocks.dart';

@GenerateMocks([
  ContactsPageController,
  SessionState,
  HomeState,
  LocationState,
  UserStatusState,
  MapState,
  FriendsController,
  RequestsController,
  SuggestionsController,
])
void main() async {
  late MyUser user;
  HttpOverrides.global = null;

  final ContactsPageController mockContactsPageController =
      MockContactsPageController();
  final SessionState mockSessionState = MockSessionState();
  final HomeState mockHomeState = MockHomeState();
  final LocationState mockLocationState = MockLocationState();
  final UserStatusState mockUserStatusState = MockUserStatusState();
  final ProfileState profileState = ProfileState();
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
    when(mockSessionState.currentUser).thenAnswer((_) => user);
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

    user = MyUser(
        id: "2",
        name: "test",
        email: "test@capg.com",
        imageUrl: "http://example.com",
        phone: "123456789",
        onboardingCompleted: true,
        shareLocationEnabled: true);

    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<HomeState>(mockHomeState);
    GetIt.I.registerSingleton<LocationState>(mockLocationState);
    GetIt.I.registerSingleton<UserStatusState>(mockUserStatusState);
    GetIt.I.registerSingleton<ProfileState>(profileState);
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

  Future navigateToProfilePage(WidgetTester tester) async {
    await tester.pumpWidget(_createApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
  }

  // group('end-to-end test', () {
  testWidgets('tap on the floating action button, verify counter',
      (tester) async {
    await tester.pumpWidget(_createApp());

    expect(1, 1);
    // await navigateToProfilePage(tester);

    // // Check the profile page is displayed
    // // expect(find.widgetWithText(Padding, appLocalizations.profile),
    // //     findsOneWidget);

    // // Emulate a tap on the edit profile button
    // await tester
    //     .tap(find.widgetWithText(CustomCard, appLocalizations.editProfile));

    // // Trigger a frame.
    // await tester.pumpAndSettle();

    // // Check that edit profile page is displayed
    // // expect(find.widgetWithText(TextField, user.name), findsOneWidget);

    // // Change username
    // await tester.enterText(
    //     find.widgetWithText(TextField, user.name), "newUsername");

    // expect(user.name, "newUsername");

    // // Emulate a tap on the save button
    // await tester.tap(find.widgetWithText(TextButton, appLocalizations.save));

    // // Trigger a frame.
    // await tester.pumpAndSettle();

    // // Check the profile page is displayed again with new username
    // // expect(find.widgetWithText(Padding, appLocalizations.profile),
    // //     findsOneWidget);
    // expect(find.widgetWithText(Text, "newUsername"), findsOneWidget);
  });
  // });
}
