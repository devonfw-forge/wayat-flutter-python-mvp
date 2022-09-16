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
  late Language itemSelected;

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {

    final List<Language> itemList = Language.languageList(context);
    itemSelected = itemList.first;

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getTranslated(context, 'language')!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(width: 20,),
            DropdownButton<Language>(
              value: itemSelected,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Colors.grey[200],
              onChanged: (Language? language) {
                if (language != null) {
                  _changeLanguage(language);
                  setState(() {
                    itemSelected = language;
                  });
                }
              },
              items: itemList
                  .map<DropdownMenuItem<Language>>(
                    (e) =>
                        DropdownMenuItem<Language>(value: e, child: Text(e.name!, style: const TextStyle(fontSize: 20),)),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
