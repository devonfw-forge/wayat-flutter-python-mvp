import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/authentication/auth_service.dart';

import 'session_state_test.mocks.dart';

@GenerateMocks([AuthService, GoogleSignInAccount])
void main() async {
  MyUser testUser = _generateMyUser("Test");

  test(
      "doneOnboarding updates onboarding state to done and notifies the server",
      () async {
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.sendDoneOnboarding(true))
        .thenAnswer((_) => Future.value(true));

    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.currentUser = testUser;

    expect(sessionState.hasDoneOnboarding, false);
    expect(sessionState.currentUser!.onboardingCompleted, false);

    await sessionState.doneOnBoarding();

    expect(sessionState.hasDoneOnboarding, true);
    expect(sessionState.currentUser!.onboardingCompleted, true);
    verify(mockAuthService.sendDoneOnboarding(true)).called(1);
  });

  test("isLogged does not initialize the user if is signed in", () async {
    AuthService mockAuthService = MockAuthService();

    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.currentUser = testUser;
    sessionState.googleSignedIn = true;

    expect(sessionState.googleSignedIn, true);

    await sessionState.isLogged();

    verifyNever(mockAuthService.getUserData());
    expect(sessionState.googleSignedIn, true);
  });

  test(
      "isLogged signs in silently if the user is not signed in and has account",
      () async {
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.signInSilently())
        .thenAnswer((_) => Future.value(MockGoogleSignInAccount()));
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(testUser));

    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.googleSignedIn = false;

    await sessionState.isLogged();

    verify(mockAuthService.signInSilently()).called(1);
    verify(mockAuthService.getUserData()).called(1);
    expect(sessionState.googleSignedIn, true);
  });

  test("isLogged does not sign in if the user does not have and account",
      () async {
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.signInSilently())
        .thenAnswer((_) => Future.value(null));

    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.googleSignedIn = false;

    await sessionState.isLogged();

    verify(mockAuthService.signInSilently()).called(1);
    expect(sessionState.googleSignedIn, false);
  });

  test("SetGoogleSignIn works correctly", () async {
    AuthService mockAuthService = MockAuthService();

    SessionState sessionState = SessionState(authService: mockAuthService);
    expect(sessionState.googleSignedIn, false);

    sessionState.setGoogleSignIn(true);

    expect(sessionState.googleSignedIn, true);
  });

  test("SetFinishLoggedIn works correctly", () async {
    AuthService mockAuthService = MockAuthService();

    SessionState sessionState = SessionState(authService: mockAuthService);
    expect(sessionState.finishLoggedIn, false);

    sessionState.setFinishLoggedIn(true);

    expect(sessionState.finishLoggedIn, true);
  });

  test("InitializeUser asigns a value only if the current user is not null",
      () async {
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(testUser));

    SessionState sessionState = SessionState(authService: mockAuthService);
    expect(sessionState.currentUser, null);

    await sessionState.initializeUser();

    expect(sessionState.currentUser, testUser);

    MyUser otherUser = testUser.copyWith(id: "otherId");
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(otherUser));

    await sessionState.initializeUser();

    expect(sessionState.currentUser, testUser);
  });

  test("UpdateCurrentUser fetchs the user data using the AuthService",
      () async {
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(testUser));

    SessionState sessionState = SessionState(authService: mockAuthService);
    await sessionState.updateCurrentUser();

    verify(mockAuthService.getUserData()).called(1);
  });

  test("UpdatePhone changes user's phone and notifies the server", () async {
    MyUser myUser = _generateMyUser("TestA");
    String newPhone = "${myUser.phone}1234";
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.sendPhoneNumber(newPhone))
        .thenAnswer((_) => Future.value(true));

    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.currentUser = myUser;

    expect(sessionState.currentUser!.phone, myUser.phone);

    await sessionState.updatePhone(newPhone);

    expect(sessionState.currentUser!.phone, newPhone);

    verify(mockAuthService.sendPhoneNumber(newPhone)).called(1);
  });

  test("UpdatePhone If notifiying the server fails, the phone does not update",
      () async {
    MyUser myUser = _generateMyUser("TestA");
    String newPhone = "${myUser.phone}1234";
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.sendPhoneNumber(newPhone))
        .thenAnswer((_) => Future.value(false));

    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.currentUser = myUser;

    expect(sessionState.currentUser!.phone, myUser.phone);

    await sessionState.updatePhone(newPhone);

    expect(sessionState.currentUser!.phone != newPhone, true);

    verify(mockAuthService.sendPhoneNumber(newPhone)).called(1);
  });

  test("SetDoneOnBoarding marks the onboarding as completed", () async {
    MyUser myUser = _generateMyUser("TestA");
    myUser.onboardingCompleted = false;
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.sendDoneOnboarding(true))
        .thenAnswer((_) => Future.value(true));

    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.currentUser = myUser;

    expect(sessionState.isOnboardingCompleted(), false);

    await sessionState.setDoneOnBoarding();

    expect(sessionState.isOnboardingCompleted(), true);

    verify(mockAuthService.sendDoneOnboarding(true)).called(1);
  });

  test(
      "SetDoneOnBoarding if notifying the server fails, the onboarding does not complete",
      () async {
    MyUser myUser = _generateMyUser("TestA");
    myUser.onboardingCompleted = false;
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.sendDoneOnboarding(true))
        .thenAnswer((_) => Future.value(false));

    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.currentUser = myUser;

    expect(sessionState.isOnboardingCompleted(), false);

    await sessionState.setDoneOnBoarding();

    expect(sessionState.isOnboardingCompleted(), false);

    verify(mockAuthService.sendDoneOnboarding(true)).called(1);
  });

  test("DoLoginProcess does not do anything if user is logged", () async {
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(_generateMyUser("TestUser")));
    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.googleSignedIn = true;
    expect(sessionState.finishLoggedIn, false);
    expect(sessionState.currentUser, null);

    await sessionState.doLoginProcess();

    expect(sessionState.finishLoggedIn, false);
    expect(sessionState.currentUser, null);
    verifyNever(mockAuthService.getUserData());
  });

  test("DoLoginProcess finishes login and gets user if not logged in",
      () async {
    MyUser testUser = _generateMyUser("TestUser");
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(testUser));
    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.googleSignedIn = false;
    expect(sessionState.finishLoggedIn, false);
    expect(sessionState.currentUser, null);
    expect(sessionState.googleSignedIn, false);

    await sessionState.doLoginProcess();

    expect(sessionState.finishLoggedIn, true);
    expect(sessionState.currentUser, testUser);
    expect(sessionState.googleSignedIn, true);
    verify(mockAuthService.getUserData()).called(1);
  });

  test("DoLoginProcess does not finish login if the user does not have phone",
      () async {
    MyUser testUser = _generateMyUser("TestUser");
    testUser.phone = "";
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(testUser));
    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.googleSignedIn = false;
    expect(sessionState.finishLoggedIn, false);
    expect(sessionState.currentUser, null);
    expect(sessionState.googleSignedIn, false);

    await sessionState.doLoginProcess();

    expect(sessionState.finishLoggedIn, false);
    expect(sessionState.currentUser, testUser);
    expect(sessionState.googleSignedIn, true);
    verify(mockAuthService.getUserData()).called(1);
  });

  test("InitializeUserSession sets logged in and gets user data", () async {
    MyUser testUser = _generateMyUser("TestUser");
    testUser.onboardingCompleted = true;
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(testUser));
    SessionState sessionState = SessionState(authService: mockAuthService);
    expect(sessionState.currentUser, null);
    expect(sessionState.googleSignedIn, false);
    expect(sessionState.hasDoneOnboarding, false);

    await sessionState.initializeUserSession();

    expect(sessionState.currentUser, testUser);
    expect(sessionState.googleSignedIn, true);
    expect(sessionState.hasDoneOnboarding, true);
    verify(mockAuthService.getUserData()).called(1);
  });

  test("Login calls signIn in the auth service and does login process",
      () async {
    MyUser testUser = _generateMyUser("TestUser");
    testUser.onboardingCompleted = true;
    AuthService mockAuthService = MockAuthService();
    GoogleSignInAccount mockAccount = MockGoogleSignInAccount();
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(testUser));
    when(mockAuthService.signIn()).thenAnswer((_) => Future.value(mockAccount));
    SessionState sessionState = SessionState(authService: mockAuthService);
    expect(sessionState.currentUser, null);
    expect(sessionState.googleSignedIn, false);
    expect(sessionState.hasDoneOnboarding, false);
    expect(sessionState.finishLoggedIn, false);

    await sessionState.login();

    expect(sessionState.currentUser, testUser);
    expect(sessionState.googleSignedIn, true);
    expect(sessionState.hasDoneOnboarding, true);
    expect(sessionState.finishLoggedIn, true);
    verify(mockAuthService.getUserData()).called(1);
    verify(mockAuthService.signIn()).called(1);
  });

  test("Login If there is no google account the login process is not done",
      () async {
    MyUser testUser = _generateMyUser("TestUser");
    testUser.onboardingCompleted = true;
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.getUserData())
        .thenAnswer((_) => Future.value(testUser));
    when(mockAuthService.signIn()).thenAnswer((_) => Future.value(null));
    SessionState sessionState = SessionState(authService: mockAuthService);
    expect(sessionState.currentUser, null);
    expect(sessionState.googleSignedIn, false);
    expect(sessionState.hasDoneOnboarding, false);
    expect(sessionState.finishLoggedIn, false);

    await sessionState.login();

    expect(sessionState.currentUser, null);
    expect(sessionState.googleSignedIn, false);
    expect(sessionState.hasDoneOnboarding, false);
    expect(sessionState.finishLoggedIn, false);
    verifyNever(mockAuthService.getUserData());
    verify(mockAuthService.signIn()).called(1);
  });

  test("LogOut calls signOut in Authentication service", () async {
    AuthService mockAuthService = MockAuthService();
    when(mockAuthService.signOut()).thenAnswer((_) => Future.value(null));
    SessionState sessionState = SessionState(authService: mockAuthService);

    await sessionState.logOut();

    verify(mockAuthService.signOut()).called(1);
  });

  test(
      "IsOnboardingCompleted returns the onBoardingCompleted data from the user",
      () async {
    MyUser testUser = _generateMyUser("TestUser");
    AuthService mockAuthService = MockAuthService();
    SessionState sessionState = SessionState(authService: mockAuthService);
    sessionState.currentUser = testUser;

    sessionState.currentUser!.onboardingCompleted = false;
    bool value = sessionState.isOnboardingCompleted();

    expect(value, false);

    sessionState.currentUser!.onboardingCompleted = true;
    value = sessionState.isOnboardingCompleted();

    expect(value, true);
  });

  test("HasPhone returns if the current user has a phone if it exists",
      () async {
    MyUser testUser = _generateMyUser("TestUser");
    AuthService mockAuthService = MockAuthService();
    SessionState sessionState = SessionState(authService: mockAuthService);

    expect(sessionState.currentUser, null);
    expect(sessionState.hasPhone(), false);

    testUser.phone = "";
    sessionState.currentUser = testUser;

    expect(sessionState.currentUser, testUser);
    expect(sessionState.hasPhone(), false);

    testUser.phone = "12345";
    sessionState.currentUser = testUser;

    expect(sessionState.currentUser, testUser);
    expect(sessionState.hasPhone(), true);
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
