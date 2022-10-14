import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/state/app_state.dart';

class BottomMenuSecondPage extends StatelessWidget {
  const BottomMenuSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Second bottom item"),
        ElevatedButton(
            onPressed: () => context.go("/first/itemslist/item",
                extra: GetIt.I.get<AppState>().allProducts[0]),
            child: const Text("Tomate frito"))
      ],
    );
  }
}
