import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/lang/lang_singleton.dart';

/// Get current AppLocalizations from LangSingleton
final AppLocalizations appLocalizations = GetIt.I.get<LangSingleton>().get();
