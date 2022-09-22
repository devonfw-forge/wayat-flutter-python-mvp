
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wayat/lang/language_constants.dart';

void main() async {

  test("setLocaleConstants save the language on sharePreferences", () async {
    setLocaleConstants('es');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('languageCode'), 'es');
    setLocaleConstants('en');
    prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('languageCode'), 'en');
    setLocaleConstants('fr');
    prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('languageCode'), 'fr');
    setLocaleConstants('nl');
    prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('languageCode'), 'nl');
    setLocaleConstants('de');
    prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('languageCode'), 'de');
  });

  test("getLocaleConstants get the language of sharePreferences", () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Locale getLocale = await getLocaleConstants();
    expect(prefs.getString('languageCode'), getLocale.languageCode);
  });
}
