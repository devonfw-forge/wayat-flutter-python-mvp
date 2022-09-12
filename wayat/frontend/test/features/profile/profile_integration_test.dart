import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import 'package:wayat/common/widgets/custom_card.dart';
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
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/profile/profile_service.dart';

import 'profile_integration_test.mocks.dart';

@GenerateMocks([
  ProfileService,
  ContactsPageController,
  SessionState,
  HomeState,
  LocationState,
  UserStatusState,
  MapState,
  FriendsController,
  RequestsController,
  SuggestionsController,
  HttpProvider
])
void main() async {
  late MyUser user;

  final ContactsPageController mockContactsPageController =
      MockContactsPageController();
  final SessionState mockSessionState = MockSessionState();
  final HomeState mockHomeState = MockHomeState();
  final LocationState mockLocationState = MockLocationState();
  final UserStatusState mockUserStatusState = MockUserStatusState();
  final MapState mockMapState = MockMapState();
  final FriendsController mockFriendsController = MockFriendsController();
  final RequestsController mockRequestsController = MockRequestsController();
  final SuggestionsController mockSuggestionsController =
      MockSuggestionsController();
  final ProfileService mockProfileService = MockProfileService();
  final ProfileState profileState =
      ProfileState(profileService: mockProfileService);

  setUpAll(() async {
    HttpOverrides.global = null;
    await dotenv.load(fileName: ".env");
    when(mockContactsPageController.searchBarController)
        .thenReturn(TextEditingController());
    when(mockSessionState.finishLoggedIn).thenReturn(true);
    when(mockSessionState.hasDoneOnboarding).thenReturn(true);
    when(mockSessionState.currentUser).thenAnswer((_) => user);
    when(mockSessionState.updateCurrentUser())
        .thenAnswer((_) => Future.value(null));
    when(mockHomeState.selectedContact).thenReturn(null);
    when(mockLocationState.initialize()).thenAnswer((_) => Future.value(null));
    when(mockProfileService.updateProfileName("newUsername"))
        .thenAnswer((_) => Future.value(true));
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
    when(mockLocationState.currentLocation).thenReturn(const LatLng(1, 1));

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
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
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

  testWidgets('Integration test for change username', (tester) async {
    await navigateToProfilePage(tester);

    // Check the profile page is displayed
    expect(
        find.widgetWithText(ListView, appLocalizations.profile), findsWidgets);

    // Emulate a tap on the edit profile button
    await tester.tap(find.descendant(
        of: find.widgetWithText(CustomCard, appLocalizations.editProfile),
        matching: find.byType(InkWell)));

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Emulate a tap on the back button
    await tester.tap(find.widgetWithIcon(IconButton, Icons.arrow_back));

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Check the profile page is displayed
    expect(
        find.widgetWithText(ListView, appLocalizations.profile), findsWidgets);

    // Emulate a tap on the edit profile button
    await tester.tap(find.descendant(
        of: find.widgetWithText(CustomCard, appLocalizations.editProfile),
        matching: find.byType(InkWell)));

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Check that edit profile page is displayed
    expect(find.widgetWithText(TextField, user.name), findsWidgets);

    // Change username
    await tester.enterText(
        find.widgetWithText(TextField, user.name), "newUsername");

    // Emulate a tap on the save button
    await tester.tap(find.widgetWithText(TextButton, appLocalizations.save));

    expect(user.name, "newUsername");

    // Trigger a frame.
    await tester.pumpAndSettle();

    // Check the profile page is displayed again with new username
    expect(
        find.widgetWithText(Padding, appLocalizations.profile), findsWidgets);
    expect(find.text("newUsername"), findsWidgets);
  });

  testWidgets('Integration test for enable/disable sharing location',
      (tester) async {
    when(mockLocationState.shareLocationEnabled).thenReturn(true);
    when(mockSessionState.logOut()).thenAnswer((_) => Future.value());
    when(mockLocationState.setShareLocationEnabled(false)).thenReturn(null);
    await navigateToProfilePage(tester);

    // Check the profile page is displayed
    expect(
        find.widgetWithText(ListView, appLocalizations.profile), findsWidgets);

    // Check if switch is displayed
    Finder switchF = find.byKey(const Key("sw_en_prof"));
    expect(switchF, findsOneWidget);

    //Check switch triggers callback
    await tester.tap(switchF);
    await tester.pumpAndSettle();

    await tester.tap(switchF);
    await tester.pumpAndSettle();
    verify(mockLocationState.setShareLocationEnabled(false)).called(2);
  });

  testWidgets('Integration test for LogOut', (tester) async {
    when(mockSessionState.logOut()).thenAnswer((_) => Future.value());
    await navigateToProfilePage(tester);

    // Check the profile page is displayed
    expect(
        find.widgetWithText(ListView, appLocalizations.profile), findsWidgets);

    // Emulate a tap on the logOut profile button
    await tester.tap(find.descendant(
        of: find.widgetWithText(CustomCard, appLocalizations.logOut),
        matching: find.byType(InkWell)));

    verify(mockSessionState.logOut()).called(1);
  });
}
