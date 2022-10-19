import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:spike_theme_app/theme/app_colors.dart';
import 'package:spike_theme_app/theme/app_theme.dart';

part 'theme_state.g.dart';

class ThemeState = _ThemeState with _$ThemeState;

abstract class _ThemeState with Store {
  @observable
  ThemeMode selectedThemeMode = appThemes[0].mode;

  @observable
  Color selectedPrimaryColor = AppColors.primaryColors[0];

  @action
  setSelectedThemeMode(ThemeMode themeMode) {
    selectedThemeMode = themeMode;
  }

  @action
  setSelectedPrimaryColor(Color color) {
    selectedPrimaryColor = color;
  }
}
