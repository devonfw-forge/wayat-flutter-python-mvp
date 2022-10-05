import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/features/profile/widgets/restart_ios_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'restart_ios_dialog_test.mocks.dart';

@GenerateMocks([UserState, ProfileState])
void main() async {
  final MockProfileState mockProfileState = MockProfileState();

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

  testWidgets('Restart info dialog is correct', (tester) async {
    await tester.pumpWidget(createApp(const RestartIosDialog()));
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Restart info dialoghas a correct title', (tester) async {
    await tester.pumpWidget(createApp(const RestartIosDialog()));
    expect(find.text(appLocalizations.iosChangeLangTitle), findsOneWidget);
  });

  testWidgets('Restart info dialog has a correct text', (tester) async {
    await tester.pumpWidget(createApp(const RestartIosDialog()));
    expect(find.text(appLocalizations.iosChangeLangMsg), findsOneWidget);
  });

  testWidgets('Restart info dialog has button Ok', (tester) async {
    await tester.pumpWidget(createApp(const RestartIosDialog()));
    expect(find.byType(CustomFilledButton), findsOneWidget);
    expect(find.text('Ok'), findsOneWidget);
  });
}
