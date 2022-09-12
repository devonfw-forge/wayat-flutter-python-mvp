import 'package:wayat/lang/app_localizations.dart';

class Language {
  final String name;
  final String languageCode;

  Language(this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(appLocalizations.en, 'en'),
      Language(appLocalizations.es, 'es'),
      Language(appLocalizations.ge, 'ge'),
      Language(appLocalizations.fr, 'fr'),
      Language(appLocalizations.du, 'du'),
    ];
  }
}
