import 'package:wayat/lang/app_localizations.dart';

class Language {
  final String name;
  final String languageCode;

  Language(this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language('English', 'en'),
      Language('Español', 'es'),
    ];
  }

  @override
  bool operator ==(covariant Language other) {
    if (identical(this, other)) return true;
    return name == other.name && languageCode == other.languageCode;
  }
}
