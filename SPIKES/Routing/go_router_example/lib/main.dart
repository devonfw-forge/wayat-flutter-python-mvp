import 'package:go_router_example/navigation/app_router.dart';
import 'package:go_router_example/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<AppState>(() => AppState());
  runApp(App());
}

class App extends StatelessWidget {
  final _appRouter = AppRouter.router;

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter,
    );
  }
}
