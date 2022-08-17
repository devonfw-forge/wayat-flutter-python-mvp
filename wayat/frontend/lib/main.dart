import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  await registerSingletons();

  runApp(MyApp());
}

Future registerSingletons() async {
  //Register with GetIt all the singletons for the repos like this
  //GetIt.I.registerLazySingleton<AbstractClass>(() => ImplementationClass())
  GetIt.I.registerLazySingleton<LangSingleton>(() => LangSingleton());
  GetIt.I.registerLazySingleton<OnboardingController>(
      () => OnboardingController());
  GetIt.I.registerLazySingleton<SessionState>(() => SessionState());
  GetIt.I.registerLazySingleton<ContactsPageController>(
      () => ContactsPageController());
  GetIt.I.registerLazySingleton<UserStatusState>(() => UserStatusState());
  GetIt.I.registerLazySingleton<LocationState>(() => LocationState());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SessionState userSession = GetIt.I.get<SessionState>();

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
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
