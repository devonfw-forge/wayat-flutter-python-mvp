import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/lang/language.dart';

void main() async {
  late AppConfigState appConfigState;

  setUp(() {
    appConfigState = AppConfigState();
  });

  test("initialize locale", () async {
    (await SharedPreferences.getInstance()).setString("languageCode", "en");
    await appConfigState.initializeLocale();
    expect(appConfigState.language, Language("English", "en"));
  });

  test("getLanguage method", () async {
    expect(appConfigState.getLanguage("es"), Language("Español", "es"));
    expect(appConfigState.getLanguage("fr"), Language("Français", "fr"));
    expect(appConfigState.getLanguage("de"), Language("Deutsch", "de"));
    expect(appConfigState.getLanguage("nl"), Language("Dutch", "nl"));
    expect(appConfigState.getLanguage("en"), Language("English", "en"));
  });

  test("change language", () async {
    Locale testLocale = const Locale("en", "US");
    appConfigState.locale = testLocale;
    Language testLanguage = Language("en", "US");
    appConfigState.language = testLanguage;

    await appConfigState.changeLanguage(Language("Español", "es"));
    expect(appConfigState.locale, const Locale("es", "ES"));
    expect(appConfigState.language, Language("Español", "es"));
  });
}
