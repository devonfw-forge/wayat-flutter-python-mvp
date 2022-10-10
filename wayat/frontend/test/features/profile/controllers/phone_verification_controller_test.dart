import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/common/widgets/phoneVerificationField/phone_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'phone_verification_controller_test.mocks.dart';

@GenerateMocks([UserState])
void main() async {
  late PhoneVerificationController phoneVerificationController;
  final MockUserState mockUserState = MockUserState();
  MyUser fakeUser = MyUser(
      id: "id",
      name: "test",
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phone: "+34666666666",
      onboardingCompleted: true,
      shareLocationEnabled: true);

  GetIt.I.registerSingleton<UserState>(mockUserState);
  GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
  setUp(() {
    when(mockUserState.currentUser).thenReturn(fakeUser);
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

  testWidgets("Testing change number", (tester) async {
    //   GlobalKey<FormState> formKey = GlobalKey<FormState>();

    //   await tester.pumpWidget(
    //     Builder(builder: (BuildContext context) {
    //       return createApp(Form(
    //           key: formKey,
    //           child: Column(children: [
    //             IntlPhoneField(
    //               // Only numbers are allowed as input
    //               keyboardType: TextInputType.number,
    //               invalidNumberMessage: "Invalid number",
    //               inputFormatters: <TextInputFormatter>[
    //                 FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    //               ],
    //               decoration: InputDecoration(
    //                   labelText: mockUserState.currentUser?.phone.substring(3),
    //                   errorText:
    //                       phoneVerificationController.errorPhoneFormat.isNotEmpty
    //                           ? phoneVerificationController.errorPhoneFormat
    //                           : null,
    //                   border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(10))),
    //               initialCountryCode: 'ES',
    //               autovalidateMode: AutovalidateMode.onUserInteraction,
    //               validator: (newTextValue) => phoneVerificationController
    //                   .validatePhoneNumber(newTextValue),
    //               onChanged: (phone) {
    //                 phoneVerificationController.onChangePhoneNumber(
    //                     phone, formKey, context);
    //               },
    //             )
    //           ])));
    //     }),
    //   );

    //   // Validate the same user phone number, should change errorPhoneFormat message
    //   await tester.enterText(find.byType(IntlPhoneField), "666666666");
    //   expect(phoneVerificationController.errorPhoneFormat,
    //       appLocalizations.phoneDifferent);
    //   // Validate the different phone number
    //   phoneVerificationController.setErrorPhoneMsg("Preventing show modal");
    //   await tester.enterText(find.byType(IntlPhoneField), "666666661");
    //   // If the message is empty it means that the phone number was correct
    //   expect(phoneVerificationController.errorPhoneFormat, "");
  });
}
