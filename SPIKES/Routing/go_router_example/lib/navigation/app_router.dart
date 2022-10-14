import 'package:go_router_example/mock/product.dart';
import 'package:go_router_example/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final GlobalKey<NavigatorState> _shellNavigatorKey2 =
    GlobalKey<NavigatorState>(debugLabel: 'shell2');

class AppRouter {
  static final router = GoRouter(
      initialLocation: "/first",
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        // Currently, a extra shell router is needed to put another screen ontop of a previous one, as happens with /first/item/list and /first/item
        ShellRoute(
          builder: (context, state, child) => Expanded(
            child: child,
          ),
          navigatorKey: _shellNavigatorKey,
          routes: [
            ShellRoute(
                navigatorKey: _shellNavigatorKey2,
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
                            parentNavigatorKey: _shellNavigatorKey,
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
        )
      ]);
}
