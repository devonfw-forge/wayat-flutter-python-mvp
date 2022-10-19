import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wayat/lang/language_constants.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  test("Generate Locale correctly", () {
    expect(LanguageConstants.locale('en'), const Locale("en", "US"));

    expect(LanguageConstants.locale('es'), const Locale("es", "ES"));

    expect(LanguageConstants.locale('fr'), const Locale("fr", "FR"));

    expect(LanguageConstants.locale('de'), const Locale("de", "DE"));

    expect(LanguageConstants.locale('nl'), const Locale("nl", "NL"));

    expect(LanguageConstants.locale('unkown'), const Locale("en", "US"));
  });

  test("setLocaleConstants save the language on sharePreferences", () async {
    await LanguageConstants.setLocaleConstants('es');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('languageCode'), 'es');
  });

  test("getLocaleConstants get the language of sharePreferences", () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Locale getLocale = await LanguageConstants.getLocaleConstants();
    expect(prefs.getString('languageCode'), getLocale.languageCode);
  });
}
