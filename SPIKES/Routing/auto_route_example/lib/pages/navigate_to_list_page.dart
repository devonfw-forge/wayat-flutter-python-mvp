import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NavigateToListPage extends StatelessWidget {
  const NavigateToListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              GetIt.I.get<AppState>().viewList = true;
            },
            child: const Text("Navigate to items page")));
  }
}
