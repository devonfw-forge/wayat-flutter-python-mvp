import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/features/authentication/page/loading_page.dart';
import 'package:wayat/features/authentication/page/login_page.dart';
import 'package:wayat/features/authentication/page/phone_validation_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/contacts_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/friends_page/friends_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/requests_page/requests_page.dart';
import 'package:wayat/features/contacts/pages/contacts_page/suggestions_page/suggestions_page.dart';
import 'package:wayat/features/contacts/pages/sent_requests_page/sent_requests_page.dart';
import 'package:wayat/features/home/pages/home_page.dart';
import 'package:wayat/features/map/page/home_map_page.dart';
import 'package:wayat/features/profile/pages/profile_page.dart';

class AppGoRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
      errorBuilder: (BuildContext context, GoRouterState state) =>
          const ErrorPage(),
      initialLocation: '/home',
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return HomePage();
            },
            routes: [
              GoRoute(
                  path: '/map',
                  builder: (BuildContext context, GoRouterState state) {
                    return HomeMapPage();
                  }),
              ShellRoute(
                  builder: (BuildContext context, GoRouterState state,
                      Widget child) {
                    return ContactsPage();
                  },
                  routes: [
                    GoRoute(
                        path: '/friends',
                        builder: (BuildContext context, GoRouterState state) {
                          return FriendsPage();
                        }),
                    GoRoute(
                        path: '/requests',
                        builder: (BuildContext context, GoRouterState state) {
                          return RequestsPage();
                        }),
                    GoRoute(
                        path: '/suggestions',
                        builder: (BuildContext context, GoRouterState state) {
                          return SuggestionsPage();
                        }),
                    GoRoute(
                        path: '/sent-requests',
                        parentNavigatorKey: _shellNavigatorKey,
                        builder: (BuildContext context, GoRouterState state) {
                          return SentRequestsPage();
                        })
                  ]),
              GoRoute(
                path: 'profile',
                builder: (context, state) => ProfilePage(),
              )
            ]),
        GoRoute(
            path: '/login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
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
      ]);
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
