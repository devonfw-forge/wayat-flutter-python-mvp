import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class NavigateToListPage extends StatelessWidget {
  const NavigateToListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).pushNamed("/list-items-page");
            },
            child: const Text("Navigate to items page")));
  }
}
