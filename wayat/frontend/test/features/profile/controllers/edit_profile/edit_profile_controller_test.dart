import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/edit_profile_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

import 'edit_profile_controller_test.mocks.dart';

@GenerateMocks([ProfileState, SessionState, HttpProvider])
void main() async {
  final MockProfileState mockProfileState = MockProfileState();
  final MockSessionState mockSessionState = MockSessionState();
  final MockHttpProvider mockHttpProvider = MockHttpProvider();
  MyUser fakeUser = MyUser(
      id: "id",
      name: "test",
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phone: "+34666666666",
      onboardingCompleted: true,
      shareLocationEnabled: true);

  setUpAll(() async {
    // await dotenv.load(fileName: ".env");

    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<ProfileState>(mockProfileState);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
    when(mockSessionState.currentUser).thenReturn(fakeUser);
  });

  Widget _createApp() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) {
        GetIt.I.get<LangSingleton>().initialize(context);
        return GetIt.I.get<LangSingleton>().appLocalizations.appTitle;
      },
    );
  }

  testWidgets('Check setters for edit profile controller', (tester) async {
    await tester.pumpWidget(_createApp());
    EditProfileController controller = EditProfileController();
    controller.setNewPhoneNumber("123");
    expect(controller.phoneNumber, "123");
    controller.setErrorPhoneMsg("errorVerification");
    expect(controller.errorPhoneVerificationMsg, "errorVerification");
    XFile image = XFile("");
    controller.setNewImage(image);
    expect(controller.currentSelectedImage, image);
  });

  testWidgets('Check validation of phone number', (tester) async {
    await tester.pumpWidget(_createApp());
    EditProfileController controller = EditProfileController();
    PhoneNumber emptyPhone =
        PhoneNumber(number: "", countryCode: '+34', countryISOCode: '+34');
    PhoneNumber shortPhone =
        PhoneNumber(number: "12345", countryCode: '+34', countryISOCode: '+34');
    PhoneNumber samePhone = PhoneNumber(
        number: "666666666", countryCode: '+34', countryISOCode: '+34');
    PhoneNumber correctPhone = PhoneNumber(
        number: "123456789", countryCode: '+34', countryISOCode: '+34');

    expect(controller.validatePhoneNumber(emptyPhone),
        appLocalizations.phoneEmpty);
    expect(controller.validatePhoneNumber(shortPhone),
        appLocalizations.phoneIncorrect);
    expect(controller.validatePhoneNumber(samePhone),
        appLocalizations.phoneDifferent);
    expect(controller.validatePhoneNumber(correctPhone), "");
  });
}
