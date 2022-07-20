import 'package:flutter/material.dart';
import 'package:wayat/authenticate/login_page.dart';
import 'package:wayat/navigation/app_router.dart';

void main() {
  registerRepositories();
  runApp(MyApp());
}

void registerRepositories() {
  //Register with GetIt all the singletons for the repos like this
  //GetIt.I.registerLazySingleton<AbstractClass>(ImplementationClass());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
