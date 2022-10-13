import 'package:go_router_example/mock/product.dart';
import 'package:go_router_example/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  static final router = GoRouter(
    // redirect: ((context, state) => "/first"),
    initialLocation: "/first",
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return HomePage(child: child);
          },
          routes: [
            GoRoute(
                path: "/first",
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: NavigateToListPage()),
                routes: [
                  GoRoute(
                      path: "itemslist",
                      builder: (context, state) => ItemListPage(),
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _rootNavigatorKey,
                          path: "item",
                          builder: (context, state) =>
                              ItemPage(product: state.extra as Product),
                        )
                      ])
                ]),
            GoRoute(
              path: "/second",
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: BottomMenuPage()),
            ),
            GoRoute(
              path: "/third",
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: BottomMenuSecondPage()),
            ),
          ])
    ],
  );
}
