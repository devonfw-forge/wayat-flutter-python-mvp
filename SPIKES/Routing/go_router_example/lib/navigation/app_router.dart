import 'package:get_it/get_it.dart';
import 'package:go_router_example/mock/product.dart';
import 'package:go_router_example/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/state/app_state.dart';

class AppRouter {
  static final router =
      GoRouter(initialLocation: "/first", debugLogDiagnostics: true, routes: [
    GoRoute(
        path: "/first",
        pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(child: NavigateToListPage())),
        routes: [
          GoRoute(
              path: "itemslist",
              builder: (context, state) => ItemListPage(),
              routes: [
                GoRoute(
                    path: ":id",
                    builder: (context, state) {
                      int? id = int.tryParse(state.params["id"] ?? "0");
                      id ??= 0;
                      final Product product =
                          GetIt.I.get<AppState>().allProducts[id];
                      return ItemPage(product: product);
                    })
              ])
        ]),
    GoRoute(
      path: "/second",
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomePage(child: BottomMenuPage())),
    ),
    GoRoute(
      path: "/third",
      pageBuilder: (context, state) => const NoTransitionPage(
          child: HomePage(child: BottomMenuSecondPage())),
    ),
  ]);
}
