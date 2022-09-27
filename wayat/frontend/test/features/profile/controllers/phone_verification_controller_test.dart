import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/phone_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'phone_verification_controller_test.mocks.dart';

@GenerateMocks([SessionState])
void main() async {
  late PhoneVerificationController phoneVerificationController;
  final MockSessionState mockSessionState = MockSessionState();
  MyUser fakeUser = MyUser(
      id: "id",
      name: "test",
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phone: "+34666666666",
      onboardingCompleted: true,
      shareLocationEnabled: true);

  GetIt.I.registerSingleton<SessionState>(mockSessionState);
  GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  setUp(() {
    when(mockSessionState.currentUser).thenReturn(fakeUser);
    phoneVerificationController = PhoneVerificationController();
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

  test('Set phone number', () async {
    phoneVerificationController.setNewPhoneNumber("123456789");
    expect(phoneVerificationController.phoneNumber, "123456789");
  });

  test('Set valid phone number', () async {
    expect(phoneVerificationController.validPhone, false);
    phoneVerificationController.setValidPhoneNumber("987654321");
    expect(phoneVerificationController.phoneNumber, "987654321");
    expect(phoneVerificationController.validPhone, true);
  });

  test('Set Error phone validation message', () async {
    phoneVerificationController.setErrorPhoneMsg("Error message example");
    expect(phoneVerificationController.errorPhoneVerificationMsg,
        "Error message example");
  });

  testWidgets("Testing change number", (tester) async {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    late BuildContext gcontext;
    PhoneNumber phone = PhoneNumber(
        countryCode: "+34", number: "123456789", countryISOCode: '');

    await tester.pumpWidget(
      Builder(builder: (BuildContext context) {
        gcontext = context;
        return createApp(Form(
            key: formKey,
            child: Column(children: [
              IntlPhoneField(
                // Only numbers are allowed as input
                keyboardType: TextInputType.number,
                invalidNumberMessage: "Invalid number",
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                    labelText: mockSessionState.currentUser?.phone.substring(3),
                    errorText:
                        phoneVerificationController.errorPhoneFormat.isNotEmpty
                            ? phoneVerificationController.errorPhoneFormat
                            : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                initialCountryCode: 'ES',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (newTextValue) => phoneVerificationController
                    .validatePhoneNumber(newTextValue),
                onChanged: (phone) {
                  phoneVerificationController.onChangePhoneNumber(
                      phone, formKey, context);
                },
              )
            ])));
      }),
    );

    // Validate the same user phone number, should change errorPhoneFormat message
    await tester.enterText(find.byType(IntlPhoneField), "666666666");
    expect(phoneVerificationController.errorPhoneFormat,
        appLocalizations.phoneDifferent);
    // Validate the different phone number
    phoneVerificationController.setErrorPhoneMsg("Preventing show modal");
    await tester.enterText(find.byType(IntlPhoneField), "666666661");
    // If the message is empty it means that the phone number was correct
    expect(phoneVerificationController.errorPhoneFormat, "");
  });
}
