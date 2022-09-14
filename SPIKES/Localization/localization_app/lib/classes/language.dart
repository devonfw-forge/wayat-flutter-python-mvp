import 'package:localization_app/localization/language_constants.dart';

class Language {
  final String? name;
  final String languageCode;

  Language(this.name, this.languageCode);

  static List<Language> languageList(context) {
    return <Language>[
      Language(getTranslated(context, 'en'), 'en'),
      Language(getTranslated(context, 'es'), 'es'),
    ];
  }
}
