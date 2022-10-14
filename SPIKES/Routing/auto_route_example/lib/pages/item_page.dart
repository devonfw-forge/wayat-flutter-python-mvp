import 'package:auto_route_example/mock/product.dart';
import 'package:auto_route_example/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ItemPage extends StatelessWidget {
  final Product product = GetIt.I.get<AppState>().selectedProduct!;

  ItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Item page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${product.price}€",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
