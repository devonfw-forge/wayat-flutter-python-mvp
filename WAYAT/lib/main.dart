import 'package:flutter/material.dart';
import 'package:wayat/authenticate/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  registerRepositories();
  runApp(const MyApp());
}

void registerRepositories() {
  //Register with GetIt all the singletons for the repos like this
  //GetIt.I.registerLazySingleton<AbstractClass>(ImplementationClass());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wayat',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
