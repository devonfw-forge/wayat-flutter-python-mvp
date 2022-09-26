import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:synchronized/synchronized.dart';
import 'package:wayat/app_state/home_state/home_state.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/map_state/map_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wayat/options.dart';
import 'package:wayat/services/common/http_debug_overrides/http_debug_overrides.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    log("DEBUG MODE: Using HttpOverrides");
    HttpOverrides.global = HttpDebugOverride();
  }

  // Env file should be loaded before Firebase initialization
  await dotenv.load(fileName: ".env");
  
  await Firebase.initializeApp(
      name: "WAYAT", options: CustomFirebaseOptions.currentPlatformOptions);

  await registerSingletons();
  
  setTimeAgoLocales();

  runApp(const MyApp());
}

void setTimeAgoLocales() {
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('es', timeago.EsMessages());
  timeago.setLocaleMessages('fr', timeago.FrMessages());
  timeago.setLocaleMessages('de', timeago.DeMessages());
  timeago.setLocaleMessages('nl', timeago.NlMessages());
}

Future registerSingletons() async {
  GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  GetIt.I.registerSingleton<HttpProvider>(HttpProvider());
  GetIt.I.registerSingleton<MapState>(MapState());
  GetIt.I.registerSingleton<SessionState>(SessionState());
  GetIt.I.registerSingleton<HomeState>(HomeState());
  GetIt.I.registerSingleton<ProfileState>(ProfileState());
  GetIt.I.registerSingleton<OnboardingController>(
    OnboardingController());
  GetIt.I.registerSingleton<ContactsPageController>(
    ContactsPageController());
  GetIt.I.registerSingleton<GroupsController>(GroupsController());
  GetIt.I.registerSingleton<UserStatusState>(UserStatusState());
  GetIt.I.registerLazySingleton<LocationState>(() => LocationState());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> with WidgetsBindingObserver {
  final _appRouter = AppRouter();

  final MapState mapState = GetIt.I.get<MapState>();
  final ProfileState profileState = GetIt.I.get<ProfileState>();

  // Lock for concurrent code execution
  final Lock _lock = Lock();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    // Lock is necessary, since this function is executed concurrently when changing states
    _lock.synchronized(() async {
      // It will be executed if the app is opened from background, but not when it is
      // opened for first time
      if (state == AppLifecycleState.resumed) {
        if (!mapState.mapOpened &&
            GetIt.I.get<SessionState>().currentUser != null) {
          await mapState.openMap();
        }
      }
      // Other states must execute a close map event, but detach is not included,
      // when the app is closed it can not send a request
      else if (state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        if (mapState.mapOpened) {
          await mapState.closeMap();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);

    return FutureBuilder(
        future: GetIt.I.get<ProfileState>().initializeLocale(),
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: snapshot.data,
            onGenerateTitle: (context) {
              // In the app build, the context does not contain an AppLocalizations instance.
              // However, after the title is generated the AppLocalizations instance is the
              // first time it is not null
              GetIt.I.get<LangSingleton>().initialize(context);
              return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
            },
            localeResolutionCallback:
                (Locale? locale, Iterable<Locale> supportedLocales) {
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return const Locale("en", "US");
            },
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        });
  }
}
