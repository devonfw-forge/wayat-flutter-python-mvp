import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/features/profile/widgets/pin_input_field.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pin_input_field_test.mocks.dart';

@GenerateMocks([UserState])
void main() async {
  setUpAll(() {
    GetIt.I.registerSingleton<UserState>(MockUserState());
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
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

  testWidgets('Phone textfield widget has an input textfield', (tester) async {
    await tester.pumpWidget(createApp(PinInputField(
      onSubmit: (_) {},
    )));
    expect(find.byType(PinInputField), findsOneWidget);
  });
}
