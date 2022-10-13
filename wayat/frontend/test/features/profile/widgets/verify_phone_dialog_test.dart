import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/features/profile/widgets/pin_input_field.dart';
import 'package:wayat/common/widgets/phone_verification/verify_phone_dialog.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_mock.dart';
import 'verify_phone_dialog_test.mocks.dart';

@GenerateMocks([UserState, Firebase])
void main() async {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
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

  testWidgets('Verification dialog widget has correct AlertDialog',
      (tester) async {
    await tester.pumpWidget(createApp(VerifyPhoneNumberDialog(
      phoneNumber: PhoneNumber(
          countryCode: "+34", countryISOCode: "ES", number: "123456789"),
      // callbackPhone: () {},
    )));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(PinInputField), findsOneWidget);
  });
}
