import 'package:flutter/material.dart';
import 'package:spike_theme_app/theme/app_colors.dart';
import 'package:spike_theme_app/theme/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = appThemes[0].mode;

  setSelectedThemeMode(ThemeMode themeMode) {
    selectedThemeMode = themeMode;
    notifyListeners();
  }

  Color selectedPrimaryColor = AppColors.primaryColors[0];

  setSelectedPrimaryColor(Color color) {
    selectedPrimaryColor = color;
    notifyListeners();
  }
}
