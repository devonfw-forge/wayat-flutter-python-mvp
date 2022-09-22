import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wayat/lang/language_constants.dart';

void main() async {
  test("Generate Locale correctly", () {
    expect(locale('en'), const Locale("en", "US"));
    expect(locale('es'), const Locale("es", "ES"));
    expect(locale('fr'), const Locale("fr", "FR"));
    expect(locale('de'), const Locale("de", "DE"));
    expect(locale('nl'), const Locale("nl", "NL"));
    expect(locale('unkown'), const Locale("en", "US"));
  });

  test("getLocale", () async {
    final prefsInst = await SharedPreferences.getInstance();
    prefsInst.setString("languageCode", "nl");
    expect(await getLocaleConstants(), const Locale("nl", "NL"));
  });

  test("setLocale", () async {
    setLocaleConstants("de");
    expect(await getLocaleConstants(), const Locale("de", "DE"));
  });
}
