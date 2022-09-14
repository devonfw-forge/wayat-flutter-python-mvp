import 'package:flutter/material.dart';
import 'package:localization_app/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String language_code = 'languageCode';

//languages code
const String english = 'en';
const String spanish = 'es';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(language_code, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(language_code) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case english:
      return const Locale(english, 'US');
    case spanish:
      return const Locale(spanish, "ES");
    default:
      return const Locale(english, 'US');
  }
}

String? getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).translate(key);
}