import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_controller.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/pages/edit_profile_page/edit_profile_page.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:mockito/annotations.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

import '../../../../test_common/test_app.dart';
import 'edit_profile_test.mocks.dart';

@GenerateMocks([UserState, HttpProvider, PhoneVerificationController])
void main() async {
  final MockUserState mockUserState = MockUserState();
  final MockPhoneVerificationController mockPhoneVerifController =
      MockPhoneVerificationController();

  when(mockPhoneVerifController.errorPhoneVerification).thenReturn("");
  when(mockPhoneVerifController.isValidPhone).thenReturn(false);
  when(mockPhoneVerifController.getISOCode()).thenReturn("ES");

  late MyUser user;

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    HttpOverrides.global = null;
    user = MyUser(
        id: "2",
        name: "test",
        email: "test@capg.com",
        imageUrl: "http://example.com",
        phonePrefix: "+34",
        phone: "123456789",
        onboardingCompleted: true,
        shareLocationEnabled: true);
    GetIt.I.registerSingleton<UserState>(mockUserState);
    when(mockUserState.currentUser).thenAnswer((_) => user);
    when(mockUserState.logOut()).thenAnswer((_) => Future.value());
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
    GetIt.I.registerSingleton<PhoneVerificationController>(
        mockPhoneVerifController);
  });

  group("Edit profile page has correct components", () {
    testWidgets('Profile button', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: EditProfilePage()));
      expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
      expect(
          find.descendant(
              of: find.ancestor(
                  of: find.widgetWithIcon(IconButton, Icons.arrow_back),
                  matching: find.byType(Row)),
              matching: find.text(appLocalizations.profile)),
          findsOneWidget);
    });
    testWidgets('Save button', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: EditProfilePage()));
      expect(find.widgetWithText(TextButton, appLocalizations.save),
          findsOneWidget);
    });
    testWidgets('Name edit card', (tester) async {
      await tester.pumpWidget(TestApp.createApp(body: EditProfilePage()));
      expect(find.widgetWithText(TextField, user.name), findsOneWidget);
      expect(
          find.descendant(
              of: find.ancestor(
                  of: find.widgetWithText(TextField, user.name),
                  matching: find.byType(Row)),
              matching: find.text(appLocalizations.name)),
          findsOneWidget);
    });
  });

  testWidgets('Check dialog to change photo is showed in mobile', (tester) async {
    //Avoid overflow errors
    FlutterError.onError = null;
    await tester.pumpWidget(TestApp.createApp(body: EditProfilePage()));
    await tester.tap(find.widgetWithIcon(InkWell, Icons.edit_outlined));
    await tester.pumpAndSettle();
    expect(find.text(appLocalizations.chooseProfileFoto), findsOneWidget);
  });

  testWidgets('Check dialog to change photo is showed in desktop', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    await tester.pumpWidget(TestApp.createApp(body: EditProfilePage()));
    await tester.tap(find.widgetWithIcon(InkWell, Icons.edit_outlined));
    await tester.pumpAndSettle();
    expect(find.text(appLocalizations.chooseProfileFoto), findsOneWidget);
    debugDefaultTargetPlatformOverride = null;
  });
}
