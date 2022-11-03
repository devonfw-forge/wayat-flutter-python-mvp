import 'package:get_it/get_it.dart';
import 'package:testing_e2e/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:testing_e2e/state/app_state.dart';

import '../http_responses/product.dart';

class AppRouter {
  static final router = GoRouter(
      initialLocation: "/products",
      debugLogDiagnostics: true,
      errorBuilder: (context, state) =>
          ErrorScreen(error: state.error.toString()),
      routes: [
        GoRoute(path: "/", redirect: (context, state) => "/products"),
        GoRoute(
            path: "/products",
            builder: (context, state) => ItemListPage(),
            routes: [
              GoRoute(
                  path: ":id",
                  builder: (context, state) {
                    int? id = int.tryParse(state.params["id"] ?? "0");
                    id ??= 0;
                    final Product product = GetIt.I
                        .get<AppState>()
                        .products
                        .firstWhere((element) => element.id == id);
                    return ItemPage(product: product);
                  })
            ])
      ]);
}
