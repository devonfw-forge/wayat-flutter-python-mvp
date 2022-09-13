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
import 'package:wayat/features/notifications/page/notifications_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_wrapper.dart';
import 'package:wayat/features/onboarding/pages/progress_page.dart';
import 'package:wayat/features/profile/pages/faqs_page/faqs_page.dart';
import 'package:wayat/features/profile/pages/preferences_page/preferences_page.dart';
import 'package:wayat/features/profile/pages/privacy_page/privacy_page.dart';
import 'package:wayat/features/profile/pages/edit_profile_page/edit_profile_page.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';
import 'package:wayat/features/profile/pages/profile_wraper.dart';
import 'package:wayat/features/root/root_wrapper.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: RootWrapper, initial: true, children: [
    AutoRoute(page: OnBoardingWrapper, children: [
      AutoRoute(page: OnBoardingPage),
      CustomRoute(
          page: ProgressOnboardingPage,
          transitionsBuilder: TransitionsBuilders.slideLeft)
    ]),
    AutoRoute(page: HomeWrapper, children: [
      AutoRoute(page: HomePage, children: [
        AutoRoute(page: HomeMapPage),
        //AutoRoute(page: CreateEventPage),
        AutoRoute(page: ContactsWrapper, children: [
          AutoRoute(page: ContactsPage, children: [
            AutoRoute(page: FriendsPage),
            AutoRoute(page: RequestsPage),
            AutoRoute(page: SuggestionsPage)
          ]),
          CustomRoute(
              page: SentRequestsPage,
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
          CustomRoute(
              page: GroupsWrapper,
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
              children: [
                AutoRoute(page: GroupsPage),
                AutoRoute(page: ManageGroupPage),
                AutoRoute(page: ViewGroupPage)
              ]),
        ]),
        AutoRoute(page: NotificationsPage),
        AutoRoute(page: ProfileWrapper, children: [
          AutoRoute(page: ProfilePage),
          AutoRoute(page: EditProfilePage),
          AutoRoute(page: PreferencesPage),
          AutoRoute(page: FaqsPage),
          AutoRoute(page: PrivacyPage),
        ]),
      ]),
      AutoRoute(page: ContactProfilePage)
    ]),
    AutoRoute(page: LoginWrapper, children: [
      AutoRoute(page: LoginPage),
      AutoRoute(page: PhoneValidationPage),
      AutoRoute(page: LoadingPage)
    ]),
  ]),
])
class $AppRouter {}
