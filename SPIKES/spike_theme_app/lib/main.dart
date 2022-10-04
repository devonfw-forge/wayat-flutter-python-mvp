import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spike_theme_app/app_colors.dart';
import 'package:spike_theme_app/home_page.dart';
import 'package:spike_theme_app/theme_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        child: const HomePage(),
        builder: (c, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.selectedThemeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: AppColors.getMaterialColorFromColor(
                  themeProvider.selectedPrimaryColor),
              primaryColor: themeProvider.selectedPrimaryColor,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: AppColors.getMaterialColorFromColor(
                  themeProvider.selectedPrimaryColor),
              primaryColor: themeProvider.selectedPrimaryColor,
            ),
            home: child,
          );
        },
      ),
    );
  }
}
