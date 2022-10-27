import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui' as ui;
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';

AppConfigState appConfig = GetIt.I.get<AppConfigState>();

/// Get current AppLocalizations
AppLocalizations get appLocalizations {
  return lookupAppLocalizations(appConfig.locale ?? ui.window.locale);
}
