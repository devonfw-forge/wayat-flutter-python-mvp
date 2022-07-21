import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/event_detailed_view/page/event_details_page.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/navigation/app_router.dart';

Future main() async {
  await dotenv.load(fileName: "development.env");
  registerRepositories();
  runApp(MyApp());
}

void registerRepositories() {
  //Register with GetIt all the singletons for the repos like this
  //GetIt.I.registerLazySingleton<AbstractClass>(ImplementationClass())
  GetIt.I.registerLazySingleton<LangSingleton>(() => LangSingleton());
}


class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        // In the app build, the context does not contain an AppLocalizations instance.
        // However, after the title is generated the AppLocalizations instance is the
        // first time it is not null
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
