import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/mock/product.dart';
import 'package:auto_route_example/navigation/app_router.dart';
import 'package:auto_route_example/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeWrapperPage extends StatelessWidget {
  final AppState appState = GetIt.I.get<AppState>();

  HomeWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      Product? selectedProduct = appState.selectedProduct;
      bool viewList = appState.viewList;
      return AutoRouter.declarative(
          routes: (_) => [
                const HomeRoute(),
                if (viewList) ItemListRoute(),
                if (selectedProduct != null) ItemRoute()
              ]);
    });
  }
}
