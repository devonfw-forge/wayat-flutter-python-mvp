import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Singleton wrapper of AppLocalizations to avoid using null checks 
/// in the widgets for each text
class LangSingleton {
  late AppLocalizations appLocalizations;
  
  LangSingleton();

  void initialize(context) {
    appLocalizations = AppLocalizations.of(context)!;
 }

  AppLocalizations get() {
    return appLocalizations;
  }
}