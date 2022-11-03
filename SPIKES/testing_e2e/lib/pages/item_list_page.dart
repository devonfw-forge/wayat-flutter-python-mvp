import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:testing_e2e/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ItemListPage extends StatelessWidget {
  final AppState appState = GetIt.I.get<AppState>();

  ItemListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    appState.getAllProducts();
    return Scaffold(
        appBar: AppBar(title: const Text("List items")),
        body: Center(child: Observer(builder: (context) {
          if (!appState.hasResults) {
            return Container();
          }

          if (appState.products.isEmpty) {
            return const Text('We could not find any products');
          }

          return ListView.builder(
              itemCount: appState.products.length,
              itemBuilder: ((context, index) => ListTile(
                    leading: IconButton(
                        icon: const Icon(Icons.info_rounded),
                        splashRadius: 20,
                        onPressed: () {
                          context.go(
                            "/products/${appState.products[index].id}",
                          );
                        }),
                    title: Text(appState.products[index].title ?? "unknown"),
                    trailing: Text("${appState.products[index].price}€"),
                  )));
        })));
  }
}
