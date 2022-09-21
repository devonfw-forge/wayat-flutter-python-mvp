import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/widgets/loading_widget.dart';
import 'package:wayat/features/authentication/page/loading_page.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setUpAll(() {
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  });

  group('Loading page widget tests', () {
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

    testWidgets('Loading page has a circular progress indicator',
        (tester) async {
      await tester.pumpWidget(createApp(const LoadingPage()));
      expect(find.byType(LoadingWidget), findsOneWidget);
    });
  });
}
