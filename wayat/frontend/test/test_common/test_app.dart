import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/lang/app_localizations.dart';

class TestApp {
  static late BuildContext context;

  static Widget createApp(
      {Widget? body, GoRouter? router, BuildContext? buildContext}) {
    if (!GetIt.I.isRegistered<AppConfigState>()) {
      GetIt.I.registerSingleton<AppConfigState>(AppConfigState());
    }

    router ??= GoRouter(initialLocation: "/", routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => Scaffold(
          body: body ?? Container(),
        ),
      ),
    ]);

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        TestApp.context = context;
        return appLocalizations.appTitle;
      },
      routerConfig: router,
    );
  }
}
