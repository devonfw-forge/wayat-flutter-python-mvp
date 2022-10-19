import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_controller.dart';
import 'package:wayat/navigation/app_router.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/app_state/location_state/receive_location/receive_location_state.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/common/widgets/custom_card.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/profile/profile_service.dart';

import 'profile_integration_test.mocks.dart';

@GenerateMocks([
  ProfileService,
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
  HttpProvider,
  GroupsController,
  PhoneVerificationController
])
void main() async {
  late MyUser user;

  final ReceiveLocationState mockReceiveLocationState =
      MockReceiveLocationState();
  final ContactsPageController mockContactsPageController =
      MockContactsPageController();
  final MockUserState mockUserState = MockUserState();
  final MockHomeNavState mockHomeState = MockHomeNavState();
  final MockShareLocationState mockLocationState = MockShareLocationState();
  final MockLocationListener mockLocationListener = MockLocationListener();
  final MockLifeCycleState mockMapState = MockLifeCycleState();
  final MockFriendsController mockFriendsController = MockFriendsController();
  final MockRequestsController mockRequestsController =
      MockRequestsController();
  final MockSuggestionsController mockSuggestionsController =
      MockSuggestionsController();
  final MockProfileService mockProfileService = MockProfileService();
  final MockGroupsController mockGroupsController = MockGroupsController();
  final MockPhoneVerificationController mockPhoneVerifController =
      MockPhoneVerificationController();

  setUpAll(() async {
    HttpOverrides.global = null;
    await dotenv.load(fileName: ".env");
    when(mockContactsPageController.searchBarController)
        .thenReturn(TextEditingController());
    when(mockUserState.finishLoggedIn).thenReturn(true);
    when(mockUserState.hasDoneOnboarding).thenReturn(true);
    when(mockUserState.currentUser).thenAnswer((_) => user);
    when(mockUserState.updateUserName("newUsername")).thenAnswer((_) {
      user.name = "newUsername";
      return Future.value(null);
    });
    when(mockHomeState.selectedContact).thenReturn(null);
    when(mockLocationState.initialize()).thenAnswer((_) => Future.value(null));
    when(mockProfileService.updateProfileName("newUsername"))
        .thenAnswer((_) => Future.value(true));
    when(mockLocationState.shareLocationEnabled).thenReturn(false);
    when(mockContactsPageController.currentPage)
        .thenReturn(ContactsCurrentPages.contacts);
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
    when(mockContactsPageController.requestsController)
        .thenReturn(mockRequestsController);
    when(mockContactsPageController.suggestionsController)
        .thenReturn(mockSuggestionsController);
    when(mockFriendsController.filteredContacts)
        .thenReturn(mobx.ObservableList.of([]));
    when(mockLocationListener.shareLocationState).thenReturn(mockLocationState);
    when(mockLocationListener.receiveLocationState)
        .thenReturn(mockReceiveLocationState);
    when(mockReceiveLocationState.contacts).thenReturn([]);
    when(mockLocationState.currentLocation).thenReturn(const LatLng(1, 1));
    when(mockGroupsController.updateGroups())
        .thenAnswer((_) => Future.value(true));
    when(mockGroupsController.groups)
        .thenAnswer((_) => <Group>[].asObservable());
    when(mockPhoneVerifController.errorPhoneVerification).thenReturn("");
    when(mockPhoneVerifController.isValidPhone).thenReturn(false);
    when(mockPhoneVerifController.getISOCode()).thenReturn("ES");

    user = MyUser(
        id: "2",
        name: "test",
        email: "test@capg.com",
        imageUrl: "http://example.com",
        phonePrefix: "+34",
        phone: "123456789",
        onboardingCompleted: true,
        shareLocationEnabled: true);

    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<UserState>(mockUserState);
    GetIt.I.registerSingleton<HomeNavState>(mockHomeState);
    GetIt.I.registerSingleton<ShareLocationState>(mockLocationState);
    GetIt.I.registerSingleton<LocationListener>(mockLocationListener);
    GetIt.I.registerSingleton<LifeCycleState>(mockMapState);
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
    GetIt.I.registerSingleton<GroupsController>(mockGroupsController);
    GetIt.I.registerSingleton<PhoneVerificationController>(
        mockPhoneVerifController);
  });

  Widget createApp() {
    final appRouter = AppRouter();

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      routerConfig: appRouter.router,
    );
  }

  Future navigateToProfilePage(WidgetTester tester) async {
    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
  }

  testWidgets('Integration test for change username', (tester) async {
    await navigateToProfilePage(tester);

    // Check the profile page is displayed
    expect(find.text(appLocalizations.profile), findsWidgets);

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
    expect(find.text(appLocalizations.profile), findsWidgets);

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
    when(mockUserState.logOut()).thenAnswer((_) => Future.value());
    when(mockLocationState.setShareLocationEnabled(false)).thenReturn(null);
    await navigateToProfilePage(tester);

    // Check the profile page is displayed
    expect(find.text(appLocalizations.profile), findsWidgets);

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
    when(mockUserState.logOut()).thenAnswer((_) => Future.value());
    await navigateToProfilePage(tester);

    // Check the profile page is displayed
    expect(find.text(appLocalizations.profile), findsWidgets);

    // Emulate a tap on the logOut profile button
    Finder logOutButton = find.descendant(
        of: find.widgetWithText(CustomCard, appLocalizations.logOut),
        matching: find.byType(InkWell));

    final listFinder =
        find.widgetWithText(Scrollable, appLocalizations.profileShareLocation);

    // Scroll until the item to be found appears.
    await tester.scrollUntilVisible(
      logOutButton,
      500.0,
      scrollable: listFinder,
    );

    await tester.pumpAndSettle();

    await tester.tap(logOutButton);

    verify(mockUserState.logOut()).called(1);
  });
}
