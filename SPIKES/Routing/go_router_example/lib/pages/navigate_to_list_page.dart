import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigateToListPage extends StatelessWidget {
  const NavigateToListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              context.go("/first/itemslist");
            },
            child: const Text("Navigate to items page")));
  }
}
