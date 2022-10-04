import 'package:flutter/material.dart';
import 'package:spike_theme_app/app_colors.dart';
import 'package:spike_theme_app/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = appThemes[0].mode;

  setSelectedThemeMode(ThemeMode _themeMode) {
    selectedThemeMode = _themeMode;
    notifyListeners();
  }

  Color selectedPrimaryColor = AppColors.primaryColors[0];

  setSelectedPrimaryColor(Color _color) {
    selectedPrimaryColor = _color;
    notifyListeners();
  }
}
