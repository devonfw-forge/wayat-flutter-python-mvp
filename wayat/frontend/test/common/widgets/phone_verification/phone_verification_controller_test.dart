import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

import '../../../test_common/test_app.dart';
import 'phone_verification_controller_test.mocks.dart';

@GenerateMocks([UserState, HttpProvider, PhoneVerificationController])
void main() async {
  final MockUserState mockUserState = MockUserState();
  final MockHttpProvider mockHttpProvider = MockHttpProvider();
  MyUser fakeUser = MyUser(
      id: "id",
      name: "test",
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phone: "+34666666666",
      phonePrefix: "+34",
      onboardingCompleted: true,
      shareLocationEnabled: true);

  setUpAll(() async {
    GetIt.I.registerSingleton<UserState>(mockUserState);
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
    when(mockUserState.currentUser).thenReturn(fakeUser);
  });

  testWidgets('Getter isValidPhone', (tester) async {
    await tester.pumpWidget(TestApp.createApp());
    PhoneNumber correctPhone = PhoneNumber(
        number: "123456789", countryCode: '+34', countryISOCode: 'ES');
    PhoneNumber samePhone = PhoneNumber(
        number: "666666666", countryCode: '+34', countryISOCode: 'ES');
    PhoneVerificationController phoneController = PhoneVerificationController();

    // If has an error returns false
    phoneController.errorPhoneVerification = "fake message error";
    expect(phoneController.isValidPhone, false);

    // If phone number is null returns false
    phoneController.phoneNumber = null;
    phoneController.errorPhoneVerification = null;
    expect(phoneController.isValidPhone, false);

    // If is the same number as in current user returns false
    phoneController.phoneNumber = samePhone;
    expect(phoneController.isValidPhone, false);

    // If there's no error message and is a different phone returns true
    phoneController.phoneNumber = correctPhone;
    phoneController.errorPhoneVerification = null;

    expect(phoneController.validatePhoneNumber(correctPhone), null);
  });

  testWidgets('Check validation of phone number', (tester) async {
    await tester.pumpWidget(TestApp.createApp());
    PhoneVerificationController phoneController = PhoneVerificationController();
    PhoneNumber emptyPhone =
        PhoneNumber(number: "", countryCode: '+34', countryISOCode: 'ES');
    PhoneNumber shortPhone =
        PhoneNumber(number: "12345", countryCode: '+34', countryISOCode: 'ES');
    PhoneNumber samePhone = PhoneNumber(
        number: "666666666", countryCode: '+34', countryISOCode: 'ES');
    PhoneNumber correctPhone = PhoneNumber(
        number: "123456789", countryCode: '+34', countryISOCode: 'ES');

    expect(phoneController.validatePhoneNumber(emptyPhone),
        appLocalizations.phoneEmpty);
    expect(phoneController.validatePhoneNumber(shortPhone),
        appLocalizations.phoneIncorrect);
    expect(phoneController.validatePhoneNumber(samePhone),
        appLocalizations.phoneDifferent);
    expect(phoneController.validatePhoneNumber(correctPhone), null);
  });

  testWidgets('Check validation of phone number', (tester) async {
    await tester.pumpWidget(TestApp.createApp());
    PhoneVerificationController phoneController = PhoneVerificationController();

    // Check spanish prefix with or without sign
    fakeUser.phonePrefix = "+34";
    expect(phoneController.getISOCode(), "ES");
    fakeUser.phonePrefix = "34";
    expect(phoneController.getISOCode(), "ES");

    // Check canadian prefix with or without sign
    fakeUser.phonePrefix = "+1";
    expect(phoneController.getISOCode(), "CA");
    fakeUser.phonePrefix = "1";
    expect(phoneController.getISOCode(), "CA");

    // Check that if prefix is empty it returns the first country in alphabetical order (AF)
    fakeUser.phonePrefix = "";
    expect(phoneController.getISOCode(), "AF");
    fakeUser.phonePrefix = "+";
    expect(phoneController.getISOCode(), "AF");
  });
}
