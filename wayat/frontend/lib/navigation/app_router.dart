import 'package:auto_route/auto_route.dart';
import 'package:wayat/features/authentication/page/loading_page.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/features/authentication/page/login_wrapper.dart';
import 'package:wayat/features/authentication/page/phone_validation_page.dart';
import 'package:wayat/features/contact_profile/page/contact_profile_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/contacts_page.dart';
import 'package:wayat/features/contacts/pages/contacts_wrapper.dart';
import 'package:wayat/features/contacts/pages/contacts_page/friends_page/friends_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/requests_page/requests_page.dart';
import 'package:wayat/features/contacts/pages/sent_requests_page/sent_requests_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart';
import 'package:wayat/features/groups/pages/groups_page.dart';
import 'package:wayat/features/groups/pages/groups_wrapper.dart';
import 'package:wayat/features/groups/pages/manage_group_page.dart';
import 'package:wayat/features/groups/pages/view_group_page.dart';
import 'package:wayat/features/home/pages/home_page.dart';
import 'package:wayat/features/home/pages/home_wrapper.dart';
import 'package:wayat/features/map/page/home_map_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_wrapper.dart';
import 'package:wayat/features/onboarding/pages/progress_page.dart';
import 'package:wayat/features/profile/pages/preferences_page/preferences_page.dart';
import 'package:wayat/features/profile/pages/edit_profile_page/edit_profile_page.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';
import 'package:wayat/features/profile/pages/profile_wraper.dart';
import 'package:wayat/features/root/root_wrapper.dart';

/// Defines the routes and structure in order to automatically generate the app's router.
///
/// This makes sure that the navigation stack must, at all times, follow the
/// tree structure defined in the [MaterialAutoRouter] annotation.
///
/// All pages must follow the naming convention `*Page`, to be renamed as `*Route` by the
/// [AutoRoute] library using automatic code generation.
@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: RootWrapper, path: "", initial: true, children: [
    AutoRoute(page: OnBoardingWrapper, path: "onboarding", children: [
      AutoRoute(page: OnBoardingPage, path: "allowed-contacts"),
      CustomRoute(
          page: ProgressOnboardingPage,
          path: "add-contacts",
          transitionsBuilder: TransitionsBuilders.slideLeft)
    ]),
    AutoRoute(page: HomeWrapper, path: "", children: [
      AutoRoute(page: HomePage, path: "home", children: [
        AutoRoute(page: HomeMapPage, path: "map"),
        AutoRoute(page: ContactsWrapper, path: "contacts", children: [
          AutoRoute(page: ContactsPage, path: "", children: [
            AutoRoute(page: FriendsPage, path: "friends"),
            AutoRoute(page: RequestsPage, path: "pending-requests"),
            AutoRoute(page: SuggestionsPage, path: "suggestions")
          ]),
          CustomRoute(
              page: SentRequestsPage,
              path: "sent-requests",
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
          CustomRoute(
              page: GroupsWrapper,
              path: "groups",
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
              children: [
                AutoRoute(page: GroupsPage, path: ""),
                AutoRoute(page: ManageGroupPage, path: "manage-group"),
                AutoRoute(page: ViewGroupPage, path: "group"),
                AutoRoute(
                    page: LoadingPage,
                    path: "loading",
                    name: "LoadingGroupRoute")
              ]),
        ]),
        AutoRoute(page: ProfileWrapper, path: "profile", children: [
          AutoRoute(page: ProfilePage, path: ""),
          AutoRoute(page: EditProfilePage, path: "manage-profile"),
          AutoRoute(page: PreferencesPage, path: "app-preferences"),
        ]),
      ]),
      AutoRoute(page: ContactProfilePage, path: "contact")
    ]),
    AutoRoute(page: LoginWrapper, path: "", children: [
      AutoRoute(page: LoginPage, path: "login"),
      AutoRoute(page: PhoneValidationPage, path: "phone-validation"),
      AutoRoute(page: LoadingPage, path: "loading")
    ]),
  ]),
])
class $AppRouter {}
