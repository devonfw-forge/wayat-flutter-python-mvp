import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/lang/language.dart';

void main() async {
  Language lang = Language("Example", "ex");
  Language sameLang = Language("Example", "ex");
  Language diffLang = Language("Different", "df");

  test("Build class", () {
    expect(lang.name, "Example");
    expect(lang.languageCode, "ex");
  });

  test("== operator class", () {
    expect(lang == sameLang, true);
    expect(lang == diffLang, false);
  });

  test("list languages", () {
    // ignore: unnecessary_type_check
    expect(Language.languageList() is List<Language>, true);
    expect(Language.languageList().isNotEmpty, true);
  });

  test("hashcode check", () {
    Language copyOfLang = lang;
    expect(lang.hashCode == copyOfLang.hashCode, true);
    expect(lang.hashCode == sameLang.hashCode, false);
  });
}
