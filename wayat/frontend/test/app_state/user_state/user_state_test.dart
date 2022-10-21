import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/profile/profile_service.dart';
import 'user_state_test.mocks.dart';

@GenerateMocks([
  AuthService,
  GoogleSignInAccount,
  LifeCycleState,
  ProfileService,
])
void main() async {
  MyUser myUser = _generateMyUser("Test");
  late UserState userState;
  late MockAuthService mockAuthService;
  late MockProfileService mockProfileService;
  late MockLifeCycleState mockLifeCycleState;

  setUpAll(() {
    mockLifeCycleState = MockLifeCycleState();
    GetIt.I.registerSingleton<LifeCycleState>(mockLifeCycleState);
    when(mockLifeCycleState.notifyAppOpenned())
        .thenAnswer((_) => Future.value());
    when(mockLifeCycleState.notifyAppClosed())
        .thenAnswer((_) => Future.value());
  });

  setUp(() {
    mockAuthService = MockAuthService();
    mockProfileService = MockProfileService();
    userState = UserState(
        authService: mockAuthService, profileService: mockProfileService);
  });

  test("If user hasn't log in, is logged return false", () async {
    // Emulates previous access to the app
    when(mockAuthService.signInSilently()).thenAnswer((_) => Future.value());

    expect(await userState.isLogged(), false);
  });

  test("If user has previously log in, is logged return true", () async {
    // Emulates no previous access to the app
    when(mockAuthService.signInSilently())
        .thenAnswer((_) => Future.value(MockGoogleSignInAccount()));

    expect(await userState.isLogged(), true);
  });

  test("User can log in normally with an account", () async {
    // Emulates no previous access to the app
    when(mockAuthService.signIn())
        .thenAnswer((_) => Future.value(MockGoogleSignInAccount()));

    when(mockAuthService.getUserData()).thenAnswer((_) => Future.value(myUser));

    await userState.login();

    // Check that getUserData is called inside initializeCurrentUser
    verify(mockAuthService.getUserData()).called(1);
    // Check that googleAccount is correctly set.
    expect(userState.googleAccount != null, true);
  });

  test("User cancels the log in process", () async {
    // Emulates no previous access to the app
    when(mockAuthService.signIn()).thenAnswer((_) => Future.value());

    await userState.login();

    // Check that getUserData is called inside initializeCurrentUser
    verifyNever(mockAuthService.getUserData());
    // Check that googleAccount is correctly set.
    expect(userState.googleAccount, null);
  });

  test("LogOut calls signOut in Authentication service", () async {
    when(mockLifeCycleState.notifyAppClosed())
        .thenAnswer((_) => Future.value());

    when(mockAuthService.signOut()).thenAnswer((_) => Future.value(null));

    await userState.logOut();

    verify(mockAuthService.signOut()).called(1);
  });

  test("UpdatePhone changes user's phone and notifies the server", () async {
    String newPrefix = "+789";
    String newPhone = "${myUser.phone}1234";
    when(mockAuthService.sendPhoneNumber(newPrefix, newPhone))
        .thenAnswer((_) => Future.value(true));

    userState.currentUser = myUser;

    // Checks that MyUser is correctly set with phone number
    expect(userState.currentUser!.phone, myUser.phone);

    await userState.updatePhone(newPrefix, newPhone);

    expect(userState.currentUser!.phone, newPhone);

    verify(mockAuthService.sendPhoneNumber(newPrefix, newPhone)).called(1);
  });

  test("Update image of user calls profile service method", () async {
    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));
    when(mockAuthService.getUserData()).thenAnswer((_) => Future.value(myUser));
    when(mockProfileService.uploadProfileImage(any))
        .thenAnswer((_) => Future.value(true));
    userState.updateImage(emptyFile);
    verify(mockProfileService.uploadProfileImage(emptyFile)).called(1);
  });

  test("Update username of user calls profile service method", () async {
    userState.currentUser = myUser;
    String newName = "newName";
    when(mockProfileService.updateProfileName(any))
        .thenAnswer((_) => Future.value(true));
    userState.updateUserName(newName);
    verify(mockProfileService.updateProfileName(newName)).called(1);
    expect(userState.currentUser!.name, newName);
  });

  test("Delete user calls profile service method", () async {
    when(mockProfileService.deleteCurrentUser())
        .thenAnswer((_) => Future.value(true));
    userState.deleteUser();
    verify(mockProfileService.deleteCurrentUser()).called(1);
  });
}

MyUser _generateMyUser(String name) {
  return MyUser(
      id: "id",
      name: name,
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phonePrefix: "+34",
      phone: "123",
      onboardingCompleted: false,
      shareLocationEnabled: true);
}
