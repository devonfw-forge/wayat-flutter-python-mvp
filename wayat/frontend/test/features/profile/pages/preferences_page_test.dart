import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/pages/preferences_page/preferences_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/lang/language.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

import 'preferences_page_test.mocks.dart';

@GenerateMocks([SessionState, ProfileState, HttpProvider])
void main() async {
  final MockSessionState mockSessionState = MockSessionState();
  final MockProfileState mockProfileState = MockProfileState();
  late MyUser user;

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
    user = MyUser(
        id: "25",
        name: "test",
        email: "test@capg.com",
        imageUrl: "http://example.com",
        phone: "123456789",
        onboardingCompleted: true,
        shareLocationEnabled: true);

    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    when(mockSessionState.currentUser).thenReturn(user);
    when(mockProfileState.changeLanguage(items[3]))
        .thenAnswer((_) async => null);
    when(mockProfileState.language).thenReturn(items[2]);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
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

  testWidgets('Change language row components', (tester) async {
    await tester.pumpWidget(createApp(PreferencesPage()));
    expect(find.text(appLocalizations.language), findsOneWidget);
    expect(find.text(listItems[1].value.toString()), findsNothing);
  });

  testWidgets('Choose language', (tester) async {
    await tester.pumpWidget(createApp(PreferencesPage()));
    expect(find.text(appLocalizations.language), findsOneWidget);
    await tester.tap(find.text(items[1].name));
    await tester.pumpAndSettle();
    expect(find.text(listItems[1].value.toString()), findsNothing);
  });

  testWidgets('Save button', (tester) async {
    await tester.pumpWidget(createApp(PreferencesPage()));
    expect(
        find.widgetWithText(TextButton, appLocalizations.save), findsOneWidget);
  });
}
