import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomMenuSecondPage extends StatelessWidget {
  const BottomMenuSecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Second bottom item"),
          ElevatedButton(
              onPressed: () => context.go("/first/itemslist/0"),
              child: const Text("Tomate frito"))
        ],
      ),
    );
  }
}
