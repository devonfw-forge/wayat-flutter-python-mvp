import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Get system language code
String defaultLanguage = Platform.localeName.substring(0, 2);

/// Set locale from [languageCode] and save it to SharedInstanse
Future<Locale> setLocaleConstants(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('languageCode', languageCode);
  return locale(languageCode);
}

/// Return saved locale from SharedInstanse
Future<Locale> getLocaleConstants() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString('languageCode') ?? defaultLanguage;
  if (prefs.getString('languageCode') == null) {
    await setLocaleConstants(languageCode);
  }
  return locale(languageCode);
}

@visibleForTesting
Locale locale(String languageCode) {
  switch (languageCode) {
    case 'en':
      return const Locale('en', 'US');
    case 'es':
      return const Locale('es', "ES");
    case 'fr':
      return const Locale('fr', 'FR');
    case 'de':
      return const Locale('de', 'DE');
    case 'nl':
      return const Locale('nl', "NL");
    default:
      return const Locale('en', 'US');
  }
}
