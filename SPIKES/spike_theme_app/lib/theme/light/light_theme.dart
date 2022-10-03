import 'package:flutter/material.dart';
import 'package:spike_theme_app/theme/button_theme.dart';
import 'package:spike_theme_app/theme/colors.dart';

class CustomAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: ColorTheme.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
        textTheme: ThemeData.light().textTheme,
        buttonTheme: CustomButtonTheme.lightTheme);
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: ColorTheme.primaryColor,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Montserrat',
        textTheme: ThemeData.dark().textTheme,
        buttonTheme: CustomButtonTheme.darkTheme);
  }
}
