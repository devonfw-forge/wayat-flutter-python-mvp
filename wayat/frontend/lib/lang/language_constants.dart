import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String defaultLanguage = "en";

Future<Locale> setLocaleConstants(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('languageCode', languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocaleConstants() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString('languageCode') ?? defaultLanguage;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case 'en':
      return const Locale('en', 'US');
    case 'es':
      return const Locale('es', "ES");
    default:
      return const Locale('en', 'US');
  }
}