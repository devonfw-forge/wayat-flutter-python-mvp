import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/features/profile/controllers/profile_controller.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/edit_profile_controller.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_controller.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

import 'edit_profile_controller_test.mocks.dart';

@GenerateMocks(
    [ProfileController, UserState, HttpProvider, PhoneVerificationController])
void main() async {
  final MockProfileController mockProfileController = MockProfileController();
  final MockUserState mockUserState = MockUserState();
  final MockHttpProvider mockHttpProvider = MockHttpProvider();
  final MockPhoneVerificationController mockPhoneVerifController =
      MockPhoneVerificationController();
  MyUser fakeUser = MyUser(
      id: "id",
      name: "test",
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phonePrefix: "+34",
      phone: "+34666666666",
      onboardingCompleted: true,
      shareLocationEnabled: true);

  setUpAll(() async {
    // await dotenv.load(fileName: ".env");

    GetIt.I.registerSingleton<UserState>(mockUserState);
    GetIt.I.registerSingleton<ProfileController>(mockProfileController);
    GetIt.I.registerSingleton<LangSingleton>(LangSingleton());
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
    GetIt.I.registerSingleton<MockPhoneVerificationController>(
        mockPhoneVerifController);
    when(mockUserState.currentUser).thenReturn(fakeUser);
  });

  Widget createApp() {
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
    await tester.pumpWidget(createApp());
    EditProfileController controller = EditProfileController();
    PhoneVerificationController phoneController = PhoneVerificationController();
    phoneController.phoneNumber =
        PhoneNumber(countryISOCode: "", countryCode: "", number: "123");
    expect(phoneController.phoneNumber!.completeNumber, "123");
    phoneController.errorPhoneVerification = "errorVerification";
    expect(phoneController.errorPhoneVerification, "errorVerification");
    XFile image = XFile("");
    controller.setNewImage(image);
    expect(controller.currentSelectedImage, image);
  });

  test("Saving information calls correct methods of user state", () async {
    EditProfileController controller = EditProfileController();
    String newName = "newUserName";
    XFile newUserImage = XFile.fromData(Uint8List.fromList([]));

    controller.name = newName;
    controller.currentSelectedImage = newUserImage;

    await controller.onPressedSaveButton();

    verify(mockUserState.updateUserName(any)).called(1);
    verify(mockUserState.updateImage(any)).called(1);
  });
}
