import 'package:flutter/material.dart';
import 'package:localization_app/classes/language.dart';
import 'package:localization_app/localization/language_constants.dart';
import 'package:localization_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getTranslated(context, 'language')!),
            Container(
              padding: const EdgeInsets.all(20),
              child: DropdownButton<Language>(
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.language,
                  color: Colors.blue,
                ),
                onChanged: (Language? language) {
                  if (language != null) {
                    _changeLanguage(language);
                  }
                },
                items: Language.languageList(context)
                    .map<DropdownMenuItem<Language>>(
                      (e) =>
                          DropdownMenuItem<Language>(value: e, child: Text(e.name!)),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
