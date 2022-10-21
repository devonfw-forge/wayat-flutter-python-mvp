import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestApp {
  static late BuildContext context;

  static Widget createApp(
      {Widget? body, GoRouter? router, BuildContext? buildContext}) {
    router ??= GoRouter(initialLocation: "/", routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => Scaffold(
          body: body ?? Container(),
        ),
      ),
    ]);

    if (!GetIt.I.isRegistered<LangSingleton>()) {
      GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    }

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        TestApp.context = context;
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      routerConfig: router,
    );
  }
}
