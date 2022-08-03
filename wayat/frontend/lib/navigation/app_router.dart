import 'package:auto_route/auto_route.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/features/authentication/page/login_wrapper.dart';
import 'package:wayat/features/authentication/page/phone_validation_page.dart';
import 'package:wayat/features/contacts/pages/contact_detail_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page.dart';
import 'package:wayat/features/home/pages/home_page.dart';
import 'package:wayat/features/map/home_map_page.dart';
import 'package:wayat/features/notifications/page/notifications_page.dart';
import 'package:wayat/features/create_event/page/create_event_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_wrapper.dart';
import 'package:wayat/features/onboarding/pages/progress_page.dart';
import 'package:wayat/features/root/root_wrapper.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: RootWrapper, initial: true, children: [
    AutoRoute(page: OnBoardingWrapper, children: [
      AutoRoute(page: OnBoardingPage),
      CustomRoute(
          page: ProgressOnboardingPage,
          transitionsBuilder: TransitionsBuilders.slideLeft)
    ]),
    AutoRoute(page: HomePage, children: [
      AutoRoute(page: HomeMapPage),
      AutoRoute(page: ContactsPage),
      AutoRoute(page: CreateEventPage),
      AutoRoute(page: NotificationsPage),
    ]),
    AutoRoute(page: LoginWrapper, children: [
      AutoRoute(page: LoginPage),
      AutoRoute(page: PhoneValidationPage),
    ]),
  ]),
  AutoRoute(page: ContactDetailPage),
])
class $AppRouter {}
