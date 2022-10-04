import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spike_theme_app/theme/app_colors.dart';
import 'package:spike_theme_app/home_page.dart';
import 'package:spike_theme_app/theme/theme_provider.dart';

void main() {
  GetIt.I.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final getIt = GetIt.I.get<ThemeProvider>();

  @override
  Widget build(BuildContext context) {
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
