import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/features/profile/widgets/pin_input_field.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pin_input_field_test.mocks.dart';

@GenerateMocks([SessionState])
void main() async {
  setUpAll(() {
    GetIt.I.registerSingleton<SessionState>(MockSessionState());
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  });

  Widget _createApp(Widget body) {
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

  testWidgets('Phone textfield widget has an input textfield', (tester) async {
    await tester.pumpWidget(_createApp(PinInputField(
      onSubmit: (String) {},
    )));
    expect(find.byType(PinInputField), findsOneWidget);
  });
}
