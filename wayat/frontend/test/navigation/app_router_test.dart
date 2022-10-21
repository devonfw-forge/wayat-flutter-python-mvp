import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/app_state/location_state/receive_location/receive_location_state.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_controller.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/features/authentication/page/phone_validation_page.dart';
import 'package:wayat/features/authentication/page/phone_verification_missing_page.dart';
import 'package:wayat/features/contact_profile/page/contact_profile_page.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/features/contacts/pages/contacts_page/contacts_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/friends_page/friends_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/requests_page/requests_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart';
import 'package:wayat/features/contacts/pages/sent_requests_page/sent_requests_page.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/groups/pages/groups_page.dart';
import 'package:wayat/features/groups/pages/manage_group_page.dart';
import 'package:wayat/features/groups/pages/view_group_page.dart';
import 'package:wayat/features/groups/widgets/group_tile.dart';
import 'package:wayat/features/map/page/map_page.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/features/onboarding/pages/progress_page.dart';
import 'package:wayat/features/profile/pages/edit_profile_page/edit_profile_page.dart';
import 'package:wayat/features/profile/pages/preferences_page/preferences_page.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/navigation/app_router.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/location_listener/location_listener_service.dart';

import '../test_common/test_app.dart';
import 'app_router_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UserState>(),
  MockSpec<HomeNavState>(),
  MockSpec<GroupsController>(),
  MockSpec<ContactsPageController>(),
  MockSpec<LocationListener>(),
  MockSpec<LocationListenerService>(),
  MockSpec<ReceiveLocationState>(),
  MockSpec<ShareLocationState>(),
  MockSpec<RequestsController>(),
  MockSpec<FriendsController>(),
  MockSpec<SuggestionsController>(),
  MockSpec<PhoneVerificationController>(),
  MockSpec<OnboardingController>(),
  MockSpec<AppConfigState>(),
  MockSpec<HttpProvider>(),
])
void main() async {
  late MyUser myUser;
  Contact fakeContact = Contact(
    shareLocationTo: false,
    id: "1",
    name: "fake_contact",
    email: "fakemail@mail.com",
    imageUrl: "http://fakeimage",
    phone: "+34987654321",
  );

  Group fakeGroup = Group(
      id: "1",
      members: [fakeContact],
      name: "fake group",
      imageUrl: "https://fakegroupimage");

  List<Group> fakeGroups = [fakeGroup];
  MockUserState mockUserState = MockUserState();
  MockHomeNavState mockHomeNavState = MockHomeNavState();
  GroupsController mockGroupsController = MockGroupsController();
  MockContactsPageController mockContactsPageController =
      MockContactsPageController();

  MockLocationListenerService mockLocationListenerService =
      MockLocationListenerService();
  MockReceiveLocationState mockReceiveLocationState =
      MockReceiveLocationState();

  MockShareLocationState mockShareLocationState = MockShareLocationState();

  MockLocationListener mockLocationListener = MockLocationListener();

  MockRequestsController mockRequestsController = MockRequestsController();
  MockFriendsController mockFriendsController = MockFriendsController();
  MockSuggestionsController mockSuggestionsController =
      MockSuggestionsController();
  MockPhoneVerificationController mockPhoneVerificationController =
      MockPhoneVerificationController();
  MockOnboardingController mockOnboardingController =
      MockOnboardingController();
  MockAppConfigState mockAppConfigState = MockAppConfigState();

  when(mockLocationListener.locationListenerService)
      .thenReturn(mockLocationListenerService);
  when(mockLocationListener.receiveLocationState)
      .thenReturn(mockReceiveLocationState);
  when(mockLocationListener.shareLocationState)
      .thenReturn(mockShareLocationState);

  when(mockGroupsController.groups).thenReturn(mobx.ObservableList.of([]));
  when(mockReceiveLocationState.contacts)
      .thenReturn(mobx.ObservableList.of([]));
  when(mockShareLocationState.shareLocationEnabled).thenReturn(false);
  when(mockShareLocationState.currentLocation).thenReturn(const LatLng(0, 0));

  when(mockContactsPageController.requestsController)
      .thenReturn(mockRequestsController);
  when(mockContactsPageController.friendsController)
      .thenReturn(mockFriendsController);
  when(mockContactsPageController.suggestionsController)
      .thenReturn(mockSuggestionsController);
  when(mockContactsPageController.searchBarController)
      .thenReturn(TextEditingController());
  when(mockFriendsController.filteredContacts)
      .thenReturn(mobx.ObservableList.of([fakeContact]));
  when(mockFriendsController.allContacts)
      .thenReturn(mobx.ObservableList.of([fakeContact]));
  when(mockRequestsController.filteredPendingRequests)
      .thenReturn(mobx.ObservableList.of([]));
  when(mockSuggestionsController.filteredSuggestions)
      .thenReturn(mobx.ObservableList.of([]));
  when(mockRequestsController.sentRequests)
      .thenReturn(mobx.ObservableList.of([]));
  when(mockGroupsController.groups)
      .thenReturn(mobx.ObservableList.of(fakeGroups));

  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(mockUserState);
    GetIt.I.registerSingleton<HomeNavState>(mockHomeNavState);
    GetIt.I.registerSingleton<GroupsController>(mockGroupsController);
    GetIt.I.registerSingleton<LocationListener>(mockLocationListener);
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<PhoneVerificationController>(
        mockPhoneVerificationController);
    GetIt.I.registerSingleton<OnboardingController>(mockOnboardingController);
    GetIt.I.registerSingleton<AppConfigState>(mockAppConfigState);
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
    HttpOverrides.global = null;
  });

  setUp(() {
    myUser = MyUser(
        id: "1",
        name: "My user name",
        email: "myuser@mail.com",
        imageUrl: "http://imageurl",
        phone: "+34123456789",
        phonePrefix: "+34",
        onboardingCompleted: true,
        shareLocationEnabled: false);
  });

  group("Root navigation", () {
    Future<void> navigateToRoot(tester, bool logged, bool user) async {
      when(mockUserState.isLogged())
          .thenAnswer((realInvocation) => Future.value(logged));
      if (user == true) {
        when(mockUserState.currentUser).thenReturn(myUser);
      }
      await tester.pumpWidget(TestApp.createApp(router: AppRouter().router));
      await tester.pumpAndSettle();
    }

    testWidgets("Login is the first route if user is not logged",
        (tester) async {
      await navigateToRoot(tester, false, false);
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets("Verify user is initialize if logged but null", (tester) async {
      when(mockUserState.initializeCurrentUser()).thenAnswer((realInvocation) {
        when(mockUserState.currentUser).thenReturn(myUser);
        return Future.value();
      });

      await navigateToRoot(tester, true, false);
      verify(mockUserState.initializeCurrentUser()).called(1);
      expect(find.byType(MapPage), findsOneWidget);
    });

    testWidgets(
        "Phone verification if user is logged but hasn't phone verified",
        (tester) async {
      myUser.phone = "";
      await navigateToRoot(tester, true, true);

      expect(find.byType(PhoneValidationPage), findsOneWidget);
    });

    testWidgets(
        "Phone verification if user is logged but hasn't phone verified not in mobile",
        (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      myUser.phone = "";
      await navigateToRoot(tester, true, true);

      expect(find.byType(PhoneVerificationMissingPage), findsOneWidget);
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets(
        "Onboarding is displayed if if user is logged and hasn't complete onboarding",
        (tester) async {
      myUser.onboardingCompleted = false;
      await navigateToRoot(tester, true, true);

      expect(find.byType(OnBoardingPage), findsOneWidget);

      await tester.tap(find.text(appLocalizations.next));

      await tester.pumpAndSettle();

      expect(find.byType(ProgressOnboardingPage), findsOneWidget);
    });

    testWidgets("Map is the first route if the user is logged", (tester) async {
      await navigateToRoot(tester, true, true);

      expect(find.byType(MapPage), findsOneWidget);
    });
  });

  group("Contacts navigation", () {
    Future<void> navigateToContacts(tester) async {
      when(mockUserState.isLogged())
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockUserState.currentUser).thenReturn(myUser);

      await tester.pumpWidget(TestApp.createApp(router: AppRouter().router));
      await tester.pumpAndSettle();

      expect(find.byType(MapPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.contacts_outlined));

      await tester.pumpAndSettle();
    }

    testWidgets("Navigate to contacts", (tester) async {
      await navigateToContacts(tester);

      expect(find.byType(ContactsPage), findsOneWidget);
    });

    testWidgets("Navigate to contacts expect friend request page by default",
        (tester) async {
      await navigateToContacts(tester);

      expect(find.byType(FriendsPage), findsOneWidget);
    });

    testWidgets("Navigate to a unexistent contact from contact",
        (tester) async {
      when(mockFriendsController.allContacts)
          .thenReturn(mobx.ObservableList.of([]));
      await navigateToContacts(tester);

      expect(find.byType(ContactTile), findsOneWidget);

      await tester.tap(find.byType(ContactTile));

      await tester.pumpAndSettle();

      expect(find.byType(ErrorPage), findsOneWidget);
    });

    testWidgets("Navigate to a contact profile from contact", (tester) async {
      when(mockHomeNavState.selectedContact).thenReturn(fakeContact);
      await navigateToContacts(tester);

      expect(find.byType(ContactTile), findsOneWidget);

      await tester.tap(find.byType(ContactTile));

      await tester.pumpAndSettle();

      expect(find.byType(ContactProfilePage), findsOneWidget);
    });

    testWidgets("Navigate to groups", (tester) async {
      await navigateToContacts(tester);

      await tester.tap(find.text(appLocalizations.groupsTitle));

      await tester.pumpAndSettle();

      expect(find.byType(GroupsPage), findsOneWidget);
    });

    testWidgets("Navigate to create group", (tester) async {
      await navigateToContacts(tester);

      await tester.tap(find.text(appLocalizations.groupsTitle));

      await tester.pumpAndSettle();

      when(mockGroupsController.selectedGroup).thenReturn(fakeGroup);

      await tester.tap(
          find.widgetWithText(CustomTextButton, appLocalizations.createGroup));

      await tester.pumpAndSettle();

      expect(find.byType(ManageGroupPage), findsOneWidget);
    });

    testWidgets("Navigate to a group profile", (tester) async {
      await navigateToContacts(tester);

      await tester.tap(find.text(appLocalizations.groupsTitle));

      await tester.pumpAndSettle();

      when(mockGroupsController.selectedGroup).thenReturn(fakeGroup);

      await tester.tap(find.widgetWithText(GroupTile, "fake group"));

      await tester.pumpAndSettle();

      expect(find.byType(ViewGroupPage), findsOneWidget);
    });

    testWidgets("Navigate to edit a group", (tester) async {
      await navigateToContacts(tester);

      await tester.tap(find.text(appLocalizations.groupsTitle));

      await tester.pumpAndSettle();

      when(mockGroupsController.selectedGroup).thenReturn(fakeGroup);

      await tester.tap(find.widgetWithText(GroupTile, "fake group"));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(PopupMenuButton));

      await tester.pumpAndSettle();

      await tester
          .tap(find.widgetWithText(PopupMenuItem, appLocalizations.editGroup));

      await tester.pumpAndSettle();

      expect(find.byType(ManageGroupPage), findsOneWidget);
    });

    testWidgets("Navigate to contacts request page", (tester) async {
      await navigateToContacts(tester);

      await tester.tap(find.widgetWithText(Tab, appLocalizations.requestsTab));

      await tester.pumpAndSettle();

      expect(find.byType(RequestsPage), findsOneWidget);
    });

    testWidgets("Navigate to contacts sent requests page", (tester) async {
      await navigateToContacts(tester);

      await tester.tap(find.widgetWithText(Tab, appLocalizations.requestsTab));

      await tester.pumpAndSettle();

      await tester.tap(find.text(appLocalizations.sentButtonNavigation));

      await tester.pumpAndSettle();

      expect(find.byType(SentRequestsPage), findsOneWidget);
    });

    testWidgets("Navigate to contacts suggestions page", (tester) async {
      await navigateToContacts(tester);

      await tester
          .tap(find.widgetWithText(Tab, appLocalizations.suggestionsTab));

      await tester.pumpAndSettle();

      expect(find.byType(SuggestionsPage), findsOneWidget);
    });

    testWidgets("Navigate to contacts suggestions in web redirect to friends",
        (tester) async {
      await navigateToContacts(tester);

      // Platform windows is set after navigate to can access the tab button of
      // suggestions and emulate the navigation
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      await tester
          .tap(find.widgetWithText(Tab, appLocalizations.suggestionsTab));

      await tester.pumpAndSettle();

      expect(find.byType(ContactsPage), findsOneWidget);
      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets("Navigate to contacts friends from other tab", (tester) async {
      await navigateToContacts(tester);

      await tester
          .tap(find.widgetWithText(Tab, appLocalizations.suggestionsTab));

      await tester.pumpAndSettle();

      expect(find.byType(SuggestionsPage), findsOneWidget);

      await tester.tap(find.widgetWithText(Tab, appLocalizations.friendsTab));

      await tester.pumpAndSettle();

      expect(find.byType(FriendsPage), findsOneWidget);
    });
  });

  group("Profile navigation", () {
    Future<void> navigateToProfile(tester) async {
      when(mockUserState.isLogged())
          .thenAnswer((realInvocation) => Future.value(true));
      when(mockUserState.currentUser).thenReturn(myUser);

      await tester.pumpWidget(TestApp.createApp(router: AppRouter().router));
      await tester.pumpAndSettle();

      expect(find.byType(MapPage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person_outline));

      await tester.pumpAndSettle();
    }

    testWidgets("Navigate to profile", (tester) async {
      await navigateToProfile(tester);

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets("Navigate to edit profile", (tester) async {
      await navigateToProfile(tester);

      await tester.tap(find.text(appLocalizations.editProfile));

      await tester.pumpAndSettle();

      expect(find.byType(EditProfilePage), findsOneWidget);
    });

    testWidgets("Navigate to preferences", (tester) async {
      await navigateToProfile(tester);

      await tester.tap(find.text(appLocalizations.preferences));

      await tester.pumpAndSettle();

      expect(find.byType(PreferencesPage), findsOneWidget);
    });
  });
}
