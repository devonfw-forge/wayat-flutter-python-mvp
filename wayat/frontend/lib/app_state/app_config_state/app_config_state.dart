import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/lang/language.dart';
import 'package:wayat/lang/language_constants.dart';
part 'app_config_state.g.dart';

/// Manages all preferences and configuration for the App UI
// ignore: library_private_types_in_public_api
class AppConfigState = _AppConfigState with _$AppConfigState;

abstract class _AppConfigState with Store {
  /// Store and change language
  @observable
  Language? language;

  /// Store and change Locale (language and country code)
  @observable
  Locale? locale;

  ///Initialize Locale and get language and country location
  ///
  /// Get [Locale] and [Language] which had saved before in
  /// SharedPreferences (on Android) and UserDefaults (on iOS)
  Future<Locale> initializeLocale() async {
    locale = await LanguageConstants.getLocaleConstants();
    language = getLanguage(locale!.languageCode);
    return locale!;
  }

  /// Change Language to another [language]
  @action
  Future changeLanguage(Language newLanguage) async {
    language = newLanguage;
    Locale newLocale =
        await LanguageConstants.setLocaleConstants(newLanguage.languageCode);
    locale = newLocale;
  }

  /// Return [Language] from [languageCode]
  @visibleForTesting
  Language getLanguage(String languageCode) {
    switch (languageCode) {
      case ("es"):
        return Language('Español', 'es');
      case ("fr"):
        return Language('Français', 'fr');
      case ("de"):
        return Language('Deutsch', 'de');
      case ("nl"):
        return Language('Dutch', 'nl');
      default:
        return Language('English', 'en');
    }
  }
}
