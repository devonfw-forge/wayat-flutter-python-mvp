import 'package:auto_route/auto_route.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/features/contacts/pages/contact_detail_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page.dart';
import 'package:wayat/features/home/pages/launch_page.dart';
import 'package:wayat/features/home/pages/home_provisional.dart';
import 'package:wayat/features/notifications/page/notifications_page.dart';
import 'package:wayat/features/create_event/page/create_event_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/features/onboarding/pages/progress_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: LaunchPage, initial: true, children: [
    AutoRoute(page: HomeProvPage),
    AutoRoute(page: ContactsPage),
    AutoRoute(page: CreateEventPage),
    AutoRoute(page: NotificationsPage),
  ]),
  AutoRoute(page: LoginPage, path: '/login'),
  AutoRoute(page: ContactDetailPage),
  AutoRoute(page: OnBoardingPage),
  CustomRoute(
      page: ProgressOnboardingPage,
      transitionsBuilder: TransitionsBuilders.slideLeft)
])
class $AppRouter {}
