import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:synchronized/synchronized.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/app_config/app_config_controller.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_controller.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/profile/controllers/profile_controller.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/navigation/app_go_router.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/options.dart';
import 'package:wayat/services/common/http_debug_overrides/http_debug_overrides.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Initializes the app.
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    log("DEBUG MODE: Using HttpOverrides");
    HttpOverrides.global = HttpDebugOverride();
  }

  // AVoid # character in url (flutter web)
  if (PlatformService().isWeb) {
    setPathUrlStrategy();
  }

  // Env file should be loaded before Firebase initialization
  await EnvModel.loadEnvFile();

  await Firebase.initializeApp(
      name: EnvModel.FIREBASE_APP_NAME,
      options: CustomFirebaseOptions.currentPlatformOptions);

  await registerSingletons();

  AppConfigController().setTimeAgoLocales();

  runApp(const Wayat());
}

/// Registers all the [MobX] singletons to handle the app's shared state.
///
/// All of the singletons are registered using lazy initialization, to ensure
/// that only the one's that are being used will be instantiated.
Future registerSingletons() async {
  GetIt.I.registerLazySingleton<LangSingleton>(() => LangSingleton());
  GetIt.I.registerLazySingleton<HttpProvider>(() => HttpProvider());
  GetIt.I.registerLazySingleton<LifeCycleState>(() => LifeCycleState());
  GetIt.I.registerLazySingleton<UserState>(() => UserState());
  GetIt.I.registerLazySingleton<HomeNavState>(() => HomeNavState());
  GetIt.I.registerLazySingleton<ProfileController>(() => ProfileController());
  GetIt.I.registerLazySingleton<AppConfigState>(() => AppConfigState());
  GetIt.I.registerLazySingleton<OnboardingController>(
      () => OnboardingController());
  GetIt.I.registerLazySingleton<ContactsPageController>(
      () => ContactsPageController());
  GetIt.I.registerLazySingleton<GroupsController>(() => GroupsController());
  GetIt.I.registerLazySingleton<LocationListener>(() => LocationListener());
  GetIt.I.registerLazySingleton<PhoneVerificationController>(
      () => PhoneVerificationController());
}

/// Main Application class
class Wayat extends StatefulWidget {
  const Wayat({Key? key}) : super(key: key);

  @override
  State<Wayat> createState() => _Wayat();
}

/// Main application class' state
class _Wayat extends State<Wayat> with WidgetsBindingObserver {
  /// Instance of the application router, used to handle navigation declaratively

  /// Instance of the MapState to update when the user opens and closes the map
  final LifeCycleState mapState = GetIt.I.get<LifeCycleState>();

  /// To avoid sending multiple `mapOpened` and `mapClosed` requests to the server concurrently
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

  /// Sends `mapOpened` to the server when the app opens and `mapClosed` when it is closed
  ///
  /// It handles both first startupt as well as awaking the app from minimized in Android and iOS
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    // Lock is necessary, since this function is executed concurrently when changing states
    _lock.synchronized(() async {
      // It will be executed if the app is opened from background, but not when it is
      // opened for first time
      if (state == AppLifecycleState.resumed) {
        if (!mapState.isAppOpened &&
            GetIt.I.get<UserState>().currentUser != null) {
          await mapState.notifyAppOpenned();
        }
      }
      // Other states must execute a close map event, but detach is not included,
      // when the app is closed it can not send a request
      else if (state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        if (mapState.isAppOpened) {
          await mapState.notifyAppClosed();
        }
      }
    });
  }

  /// Builds the app widget tree.
  ///
  /// Obtains the language of the system, sets it up in the first start,
  /// and then initializes the UI, internationalization singleton, and
  /// declarative router.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);

    AppGoRouter appGoRouter = AppGoRouter();

    return FutureBuilder(
        future: GetIt.I.get<AppConfigState>().initializeLocale(),
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
            routerConfig: appGoRouter.router,
          );
        });
  }
}
