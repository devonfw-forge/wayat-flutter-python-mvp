import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/features/authentication/page/loading_page.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/features/authentication/page/phone_validation_page.dart';
import 'package:wayat/features/contact_profile/page/contact_profile_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/contacts_page.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/groups/pages/groups_page.dart';
import 'package:wayat/features/groups/pages/manage_group_page.dart';
import 'package:wayat/features/groups/pages/view_group_page.dart';
import 'package:wayat/features/home/pages/home_go_page.dart';
import 'package:wayat/features/home/pages/home_tabs.dart';
import 'package:wayat/features/map/page/home_map_page.dart';
import 'package:wayat/features/profile/pages/edit_profile_page/edit_profile_page.dart';
import 'package:wayat/features/profile/pages/preferences_page/preferences_page.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

class AppGoRouter {
  final ValueKey<String> _scaffoldKey =
      const ValueKey<String>('wayat_scaffold');
  final ValueKey<String> _profileScaffoldKey =
      const ValueKey<String>('contact_profile_scaffold');
  UserState userState = GetIt.I.get<UserState>();

  late final GoRouter router = GoRouter(
    errorBuilder: (context, state) => const ErrorPage(),
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      if (await userState.isLogged()) {
        if (userState.currentUser == null) {
          await userState.initializeCurrentUser();
        }
        if (state.location == '/') {
          return '/map';
        }
      } else {
        if (state.location != '/login') {
          return '/login';
        }
      }
      return null;
    },
    routes: [
      // Makes map the default page if you enter just the domain name
      GoRoute(path: '/', redirect: (_, __) => '/map'),
      GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          }),
      // Main screen navigation
      GoRoute(
          path: '/map',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
              key: _scaffoldKey,
              child: HomeGoPage(
                selectedSection: HomeTab.map,
                child: HomeMapPage(),
              ),
            );
          }),
      GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => FadeTransitionPage(
                key: _scaffoldKey,
                child: HomeGoPage(
                  selectedSection: HomeTab.profile,
                  child: ProfilePage(),
                ),
              ),
          routes: [
            GoRoute(
              path: "edit",
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: HomeGoPage(
                    selectedSection: HomeTab.profile,
                    child: EditProfilePage(),
                  ),
                );
              },
            ),
            GoRoute(
              path: "preferences",
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: HomeGoPage(
                    selectedSection: HomeTab.profile,
                    child: PreferencesPage(),
                  ),
                );
              },
            )
          ]),
      GoRoute(
        path: '/contact/:id',
        redirect: (context, state) async {
          HomeNavState homeNavState = GetIt.I.get<HomeNavState>();
          await homeNavState.handleNavigation(state.params['id']!);
          if (homeNavState.selectedContact == null) {
            return '/not-found';
          }
          return null;
        },
        pageBuilder: (context, state) {
          return FadeTransitionPage(
              key: _profileScaffoldKey,
              child: ContactProfilePage(
                  contact: GetIt.I.get<HomeNavState>().selectedContact!,
                  navigationSource: state.extra as String? ?? "/map"));
        },
      ),
      GoRoute(path: '/contacts', redirect: (_, __) => '/contacts/friends'),
      GoRoute(
          path: '/contacts/:kind(friends|requests|suggestions)',
          redirect: (context, state) {
            if (PlatformService().isDesktopOrWeb &&
                state.location == '/contacts/suggestions') {
              return '/contacts/friends';
            }
            return null;
          },
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                key: _scaffoldKey,
                child: HomeGoPage(
                  selectedSection: HomeTab.contacts,
                  child: ContactsPage(state.params['kind'] ?? "friends"),
                ));
          }),
      GoRoute(
          path: '/contacts/groups',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                key: _scaffoldKey,
                child: HomeGoPage(
                  selectedSection: HomeTab.contacts,
                  child: GroupsPage(),
                ));
          },
          routes: [
            GoRoute(
                path: 'create',
                pageBuilder: (context, state) => NoTransitionPage(
                      child: HomeGoPage(
                        selectedSection: HomeTab.contacts,
                        child: ManageGroupPage(),
                      ),
                    )),
            GoRoute(
                path: ':id',
                redirect: (context, state) async {
                  GroupsController groupsController =
                      GetIt.I.get<GroupsController>();
                  await groupsController
                      .prepareStateForIdPage(state.params['id']!);
                  if (groupsController.selectedGroup == null) {
                    return '/not-found';
                  }
                  return null;
                },
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                      child: HomeGoPage(
                    selectedSection: HomeTab.contacts,
                    child: ViewGroupPage(),
                  ));
                })
          ]),
      GoRoute(
          path: '/phone-validation',
          builder: (BuildContext context, GoRouterState state) {
            return PhoneValidationPage();
          }),
      GoRoute(
          path: '/loading',
          builder: (BuildContext context, GoRouterState state) {
            return const LoadingPage();
          }),
    ],
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Error page"),
      ),
    );
  }
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
            key: key,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ),
            child: child);

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
