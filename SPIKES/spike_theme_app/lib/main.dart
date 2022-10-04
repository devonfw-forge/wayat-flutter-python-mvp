import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spike_theme_app/theme/app_colors.dart';
import 'package:spike_theme_app/home_page.dart';
import 'package:spike_theme_app/theme/controller/theme_state.dart';

void main() {
  GetIt.I.registerLazySingleton<ThemeState>(() => ThemeState());
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _App();
}

class _App extends State<App> with WidgetsBindingObserver {
  final getIt = GetIt.I.get<ThemeState>();

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
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);

    return FutureBuilder(
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: getIt.selectedThemeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch:
                AppColors.getMaterialColorFromColor(getIt.selectedPrimaryColor),
            primaryColor: getIt.selectedPrimaryColor,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch:
                AppColors.getMaterialColorFromColor(getIt.selectedPrimaryColor),
            primaryColor: getIt.selectedPrimaryColor,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
