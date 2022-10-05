import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'user_state_test.mocks.dart';

@GenerateMocks([AuthService, GoogleSignInAccount, LifeCycleState])
void main() async {
  MyUser myUser = _generateMyUser("Test");
  late UserState userState;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    userState = UserState(authService: mockAuthService);
  });

  test("Check if user has finished or not the authentication process",
      () async {
    // Check if user exist
    expect(userState.finishLoggedIn, false);
    // Check if user is not null
    userState.currentUser = myUser;
    expect(userState.finishLoggedIn, true);
    //Check if user has assign a phone number
    myUser.phone = "";
    userState.currentUser = myUser;
    expect(userState.finishLoggedIn, false);
  });

  test("Check if user has finished or not the onboarding process", () async {
    expect(userState.hasDoneOnboarding, false);
    // The generated user hasn't completed the onboarding
    userState.currentUser = myUser;
    expect(userState.hasDoneOnboarding, false);
    //Check if user has assign a phone number
    myUser.onboardingCompleted = true;
    userState.currentUser = myUser;
    expect(userState.hasDoneOnboarding, true);
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
    final MockLifeCycleState mockLifeCycleState = MockLifeCycleState();
    GetIt.I.registerLazySingleton<LifeCycleState>(() => mockLifeCycleState);
    when(mockLifeCycleState.notifyAppClosed())
        .thenAnswer((_) => Future.value());

    when(mockAuthService.signOut()).thenAnswer((_) => Future.value(null));

    await userState.logOut();

    verify(mockAuthService.signOut()).called(1);
  });

  test("UpdatePhone changes user's phone and notifies the server", () async {
    String newPhone = "${myUser.phone}1234";
    when(mockAuthService.sendPhoneNumber(newPhone))
        .thenAnswer((_) => Future.value(true));

    userState.currentUser = myUser;

    // Checks that MyUser is correctly set with phone number
    expect(userState.currentUser!.phone, myUser.phone);

    await userState.updatePhone(newPhone);

    expect(userState.currentUser!.phone, newPhone);

    verify(mockAuthService.sendPhoneNumber(newPhone)).called(1);
  });
}

MyUser _generateMyUser(String name) {
  return MyUser(
      id: "id",
      name: name,
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phone: "123",
      onboardingCompleted: false,
      shareLocationEnabled: true);
}
