import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/features/profile/pages/preferences_page/preferences_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/lang/language.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

import 'preferences_page_test.mocks.dart';

@GenerateMocks([SessionState, ProfileState])
void main() async {
  final MockSessionState mockSessionState = MockSessionState();
  final MockProfileState mockProfileState = MockProfileState();

  List<Language> items = [
    Language('English', 'en'),
    Language('Español', 'es'),
    Language('Français', 'fr'),
    Language('Deutsch', 'de'),
    Language('Dutch', 'nl')
  ];

  final List<DropdownMenuItem<Language>> listItems =
      items.map<DropdownMenuItem<Language>>((Language e) {
    return DropdownMenuItem<Language>(
      key: ValueKey<Language>(e),
      value: e,
      child: Text(e.name, key: ValueKey<Language>(e)),
    );
  }).toList();

  setUpAll(() {
    HttpOverrides.global = null;
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<ProfileState>(mockProfileState);
  });

  Widget createApp(Widget body) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('Save button', (tester) async {
    await tester.pumpWidget(createApp(PreferencesPage()));
    expect(
        find.widgetWithText(TextButton, appLocalizations.save), findsOneWidget);
  });

  testWidgets('Change language row', (tester) async {
    await tester.pumpWidget(createApp(PreferencesPage()));
    expect(find.widgetWithText(TextField, appLocalizations.language),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.ancestor(
                of: find.text(appLocalizations.language),
                matching: find.byType(Row)),
            matching: find.byType(List<Language>)),
        findsOneWidget);
  });

  testWidgets('Back to Profile page button', (tester) async {
    await tester.pumpWidget(createApp(PreferencesPage()));
    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(
        find.descendant(
            of: find.ancestor(
                of: find.widgetWithIcon(IconButton, Icons.arrow_back),
                matching: find.byType(Row)),
            matching: find.text(appLocalizations.profile)),
        findsOneWidget);
  });
}
