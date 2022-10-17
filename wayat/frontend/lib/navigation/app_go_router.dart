import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/features/authentication/page/loading_page.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/features/authentication/page/phone_validation_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/contacts_page.dart';
import 'package:wayat/features/home/pages/home_go_page.dart';
import 'package:wayat/features/home/pages/home_tabs.dart';
import 'package:wayat/features/map/page/home_map_page.dart';
import 'package:wayat/features/profile/pages/edit_profile_page/edit_profile_page.dart';
import 'package:wayat/features/profile/pages/preferences_page/preferences_page.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

class AppGoRouter {
  final ValueKey<String> _scaffoldKey =
      const ValueKey<String>('wayat_scaffold');
  UserState userState = GetIt.I.get<UserState>();

  late final GoRouter router = GoRouter(
    initialLocation: "/login",
    errorBuilder: (context, state) => const ErrorPage(),
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      if (await userState.isLogged()) {
        if (userState.currentUser == null) {
          await userState.initializeCurrentUser();
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
      // GoRoute(path: '/', redirect: (_, __) => '/map'),
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
      GoRoute(path: '/contacts', redirect: (_, __) => '/contacts/friends'),
      GoRoute(
          path: '/contacts/suggestions',
          redirect: (context, state) {
            if (PlatformService().isDesktopOrWeb) {
              return '/contacts/friends';
            }
            return null;
          }),
      GoRoute(
          path: '/contacts/:kind(friends|requests|suggestions)',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                key: _scaffoldKey,
                child: HomeGoPage(
                  selectedSection: HomeTab.contacts,
                  child: ContactsPage(state.params['kind'] ?? "friends"),
                ));
          }),
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
