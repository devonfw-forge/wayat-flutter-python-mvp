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
import 'package:wayat/common/widgets/contact_image.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:mobx/mobx.dart' as mobx;

import 'home_map_page_test.mocks.dart';

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
  GroupsController,
  MapController
])
void main() async {
  final ContactsPageController mockContactsPageController =
      MockContactsPageController();
  final HomeState mockHomeState = MockHomeState();
  final SessionState mockSessionState = MockSessionState();
  final LocationState mockLocationState = MockLocationState();
  final UserStatusState mockUserStatusState = MockUserStatusState();
  final ProfileState mockProfileState = MockProfileState();
  final MapState mockMapState = MockMapState();
  final FriendsController mockFriendsController = MockFriendsController();
  final RequestsController mockRequestsController = MockRequestsController();
  final SuggestionsController mockSuggestionsController =
      MockSuggestionsController();
  final GroupsController mockGroupsController = MockGroupsController();
  final MapController mockMapController = MockMapController();

  final MyUser user = MyUser(
      id: "2",
      name: "test",
      email: "test@capg.com",
      imageUrl: "http://example.com",
      phone: "123456789",
      onboardingCompleted: true,
      shareLocationEnabled: true);

  final Group myGroup = Group(
      id: "123",
      members: [
        Contact(
            shareLocation: true,
            available: true,
            id: "",
            name: "",
            email: "",
            imageUrl: "https://test.com",
            phone: "")
      ],
      name: "GroupTest",
      imageUrl: "https://test.com");

  setUpAll(() {
    HttpOverrides.global = null;

    when(mockContactsPageController.searchBarController)
        .thenReturn(TextEditingController());
    when(mockSessionState.finishLoggedIn).thenReturn(true);
    when(mockSessionState.hasDoneOnboarding).thenReturn(true);
    when(mockHomeState.selectedContact).thenReturn(null);
    when(mockLocationState.initialize()).thenAnswer((_) => Future.value(null));
    when(mockLocationState.currentLocation).thenReturn(const LatLng(1, 1));
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
    when(mockUserStatusState.contacts).thenReturn([]);
    when(mockProfileState.currentPage).thenReturn(ProfileCurrentPages.profile);
    when(mockSessionState.currentUser).thenReturn(user);
    when(mockGroupsController.updateGroups())
        .thenAnswer((_) => Future.value(true));
    when(mockMapController.filterGroup(myGroup))
        .thenAnswer((_) => Future.value());

    GetIt.I.allowReassignment = true;

    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    GetIt.I.registerSingleton<HomeState>(mockHomeState);
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<LocationState>(mockLocationState);
    GetIt.I.registerSingleton<UserStatusState>(mockUserStatusState);
    GetIt.I.registerSingleton<ProfileState>(mockProfileState);
    GetIt.I.registerSingleton<MapState>(mockMapState);
    GetIt.I.registerSingleton<GroupsController>(mockGroupsController);
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
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }

  testWidgets('Slider Groups without groups', (tester) async {
    final HomeState homeState = HomeState();
    GetIt.I.registerSingleton<HomeState>(homeState);
    when(mockGroupsController.groups)
        .thenAnswer((_) => <Group>[].asObservable());

    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.map));
    await tester.pumpAndSettle();

    expect(
        find.descendant(
            of: find.byKey(const Key("groupSlider")),
            matching: find.byType(ContactImage)),
        findsNothing);
  });

  testWidgets('Slider Groups with groups', (tester) async {
    final HomeState homeState = HomeState();
    GetIt.I.registerSingleton<HomeState>(homeState);
    when(mockGroupsController.groups)
        .thenAnswer((_) => <Group>[myGroup].asObservable());

    await tester.pumpWidget(createApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.map));
    await tester.pumpAndSettle();

    expect(
        find.descendant(
            of: find.byKey(const Key("groupSlider")),
            matching: find.byType(ContactImage)),
        findsOneWidget);
  });
}
