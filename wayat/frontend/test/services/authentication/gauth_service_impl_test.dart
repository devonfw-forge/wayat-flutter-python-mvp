import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_controller.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

import 'gauth_service_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<GoogleSignIn>(),
  MockSpec<HttpProvider>(),
  MockSpec<PlatformService>(),
  MockSpec<GoogleSignInAccount>(),
  MockSpec<GoogleSignInAuthentication>(),
  MockSpec<AuthCredential>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
  MockSpec<LocationListener>(),
  MockSpec<PhoneVerificationController>(),
  MockSpec<OnboardingController>(),
  MockSpec<ContactsPageController>(),
  MockSpec<LifeCycleState>(),
  MockSpec<HomeNavState>(),
  MockSpec<GroupsController>(),
  MockSpec<Response>(),
  MockSpec<FirebaseMessaging>(),
])
void main() async {
  MockHttpProvider mockHttpProvider = MockHttpProvider();
  MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();
  MockPlatformService mockPlatformService = MockPlatformService();
  MockLocationListener mockLocationListener = MockLocationListener();
  MockFirebaseMessaging mockFirebaseMessaging = MockFirebaseMessaging();

  setUpAll(() async {
    GetIt.I.registerLazySingleton<HttpProvider>(() => mockHttpProvider);
    GetIt.I.registerLazySingleton<PhoneVerificationController>(
        () => MockPhoneVerificationController());
    GetIt.I.registerLazySingleton<OnboardingController>(
        () => MockOnboardingController());
    GetIt.I.registerLazySingleton<ContactsPageController>(
        () => MockContactsPageController());
    GetIt.I.registerLazySingleton<LifeCycleState>(() => MockLifeCycleState());
    GetIt.I.registerLazySingleton<HomeNavState>(() => MockHomeNavState());
    GetIt.I
        .registerLazySingleton<GroupsController>(() => MockGroupsController());
    GetIt.I.registerLazySingleton<LocationListener>(() => mockLocationListener);
  });

  test("Creation from web platform without previous googleSignIn", () {
    when(mockPlatformService.isWeb).thenReturn(true);

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        messaging: mockFirebaseMessaging);

    expect(
        googleAuthService.googleSignIn.clientId, EnvModel.WEB_CLIENT_ID);
    expect(googleAuthService.googleSignIn.scopes, ["email"]);
  });

  test("Creation from mobile platform without previous googleSignIn", () {
    when(mockPlatformService.isWeb).thenReturn(false);

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        messaging: mockFirebaseMessaging);
    expect(googleAuthService.googleSignIn.scopes, ["email"]);
  });

  test("Creation with previous googleSignIn", () {
    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(googleAuthService.googleSignIn, mockGoogleSignIn);
  });

  test("SignIn returns account if nothing goes wrong", () async {
    MockGoogleSignInAccount mockGoogleSignInAccount = MockGoogleSignInAccount();
    MockGoogleSignInAuthentication mockGoogleSignInAuthentication =
        MockGoogleSignInAuthentication();
    MockUserCredential mockUserCredential = MockUserCredential();

    when(mockPlatformService.isMobile).thenReturn(true);
    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) async => mockGoogleSignInAccount);
    when(mockGoogleSignInAccount.authentication)
        .thenAnswer((_) async => mockGoogleSignInAuthentication);
    when(mockGoogleSignInAuthentication.accessToken).thenReturn("accessToken");
    when(mockGoogleSignInAuthentication.idToken).thenReturn("idToken");
    when(mockFirebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: "accessToken", idToken: "idToken")))
        .thenAnswer((_) async => mockUserCredential);
    when(mockFirebaseAuth.currentUser).thenReturn(MockUser());
    when(mockFirebaseMessaging.getToken()).thenAnswer((_) async => "token");
    when(mockHttpProvider.sendPostRequest(any, any))
        .thenAnswer((_) async => MockResponse());

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.signIn(), mockGoogleSignInAccount);

    verify(mockHttpProvider.sendPostRequest(
        APIContract.pushNotification, {"token": "token"})).called(1);
  });

  test("SignIn returns null if there is no google account", () async {
    when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.signIn(), null);
  });

  test("SignIn returns null if signInWithCredential goes wrong", () async {
    MockGoogleSignInAccount mockGoogleSignInAccount = MockGoogleSignInAccount();
    MockGoogleSignInAuthentication mockGoogleSignInAuthentication =
        MockGoogleSignInAuthentication();
    MockUserCredential mockUserCredential = MockUserCredential();

    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) async => mockGoogleSignInAccount);
    when(mockGoogleSignInAccount.authentication)
        .thenAnswer((_) async => mockGoogleSignInAuthentication);
    when(mockGoogleSignInAuthentication.accessToken).thenReturn("accessToken");
    when(mockGoogleSignInAuthentication.idToken).thenReturn("idToken");
    when(mockFirebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: "accessToken", idToken: "idToken")))
        .thenAnswer((_) async => mockUserCredential);
    when(mockFirebaseAuth.currentUser).thenReturn(null);

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.signIn(), null);
  });

  test(
      "SignIn returns null if account.authentication throws a PlatformException",
      () async {
    MockGoogleSignInAccount mockGoogleSignInAccount = MockGoogleSignInAccount();

    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) async => mockGoogleSignInAccount);
    when(mockGoogleSignInAccount.authentication)
        .thenThrow(PlatformException(code: 'code'));

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.signIn(), null);
  });

  test("getUserData calls the correct endpoint and returns correct data",
      () async {
    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);
    when(mockHttpProvider.sendGetRequest(APIContract.userProfile))
        .thenAnswer((_) async => {
              'email': 'email',
              'name': 'name',
              'image_url': "imageUrl",
              'id': 'id',
              'onboarding_completed': true,
              'phone': 'phone',
              'phone_prefix': 'prefix',
              'share_location': true,
            });

    MyUser res = await googleAuthService.getUserData();

    verify(mockHttpProvider.sendGetRequest(APIContract.userProfile)).called(1);
    expect(res, defaultUser());
  });

  test(
      "getIdToken returns empty string if auth.currentUser is null and the idToken otherwise",
      () async {
    MockUser mockUser = MockUser();

    when(mockFirebaseAuth.currentUser).thenReturn(null);
    when(mockUser.getIdToken()).thenAnswer((_) async => "idToken");

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.getIdToken(), "");

    when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

    expect(await googleAuthService.getIdToken(), "idToken");
  });

  test("signInSilenty returns null if the user has just signed out", () async {
    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);
    googleAuthService.hasSignedOut = true;

    expect(await googleAuthService.signInSilently(), null);
    expect(googleAuthService.hasSignedOut, false);
  });

  test("signInSilently returns account if nothing goes wrong", () async {
    MockGoogleSignInAccount mockGoogleSignInAccount = MockGoogleSignInAccount();
    MockGoogleSignInAuthentication mockGoogleSignInAuthentication =
        MockGoogleSignInAuthentication();
    MockUserCredential mockUserCredential = MockUserCredential();

    when(mockGoogleSignIn.signInSilently())
        .thenAnswer((_) async => mockGoogleSignInAccount);
    when(mockGoogleSignInAccount.authentication)
        .thenAnswer((_) async => mockGoogleSignInAuthentication);
    when(mockGoogleSignInAuthentication.accessToken).thenReturn("accessToken");
    when(mockGoogleSignInAuthentication.idToken).thenReturn("idToken");
    when(mockFirebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: "accessToken", idToken: "idToken")))
        .thenAnswer((_) async => mockUserCredential);
    when(mockFirebaseAuth.currentUser).thenReturn(MockUser());

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.signInSilently(), mockGoogleSignInAccount);
  });

  test("signInSilently returns null if there is no google account", () async {
    when(mockGoogleSignIn.signInSilently()).thenAnswer((_) async => null);

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.signInSilently(), null);
  });

  test("signInSilently returns null if signInWithCredential goes wrong",
      () async {
    MockGoogleSignInAccount mockGoogleSignInAccount = MockGoogleSignInAccount();
    MockGoogleSignInAuthentication mockGoogleSignInAuthentication =
        MockGoogleSignInAuthentication();
    MockUserCredential mockUserCredential = MockUserCredential();

    when(mockGoogleSignIn.signIn())
        .thenAnswer((_) async => mockGoogleSignInAccount);
    when(mockGoogleSignInAccount.authentication)
        .thenAnswer((_) async => mockGoogleSignInAuthentication);
    when(mockGoogleSignInAuthentication.accessToken).thenReturn("accessToken");
    when(mockGoogleSignInAuthentication.idToken).thenReturn("idToken");
    when(mockFirebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: "accessToken", idToken: "idToken")))
        .thenAnswer((_) async => mockUserCredential);
    when(mockFirebaseAuth.currentUser).thenReturn(null);

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.signInSilently(), null);
  });

  test("sendPhoneNumber calls the correct endpoint with correct data",
      () async {
    when(mockHttpProvider.sendPostRequest(any, any))
        .thenAnswer((_) async => Response("", 200));

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.sendPhoneNumber("+34", "123456789"), true);
    verify(mockHttpProvider.sendPostRequest(APIContract.userProfile,
        {"phone": "123456789", "phone_prefix": "+34"}));
  });

  test("sendDoneOnboarding calls the correct endpoint with correct data",
      () async {
    when(mockHttpProvider.sendPostRequest(any, any))
        .thenAnswer((_) async => Response("", 200));

    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(await googleAuthService.sendDoneOnboarding(), true);
    verify(mockHttpProvider.sendPostRequest(
        APIContract.userProfile, {"onboarding_completed": true}));
  });

  test("signOut is correct", () async {
    GoogleAuthService googleAuthService = GoogleAuthService(
        auth: mockFirebaseAuth,
        platformService: mockPlatformService,
        gS: mockGoogleSignIn,
        messaging: mockFirebaseMessaging);

    expect(googleAuthService.hasSignedOut, false);

    await googleAuthService.signOut();

    verify(mockFirebaseAuth.signOut()).called(1);
    verify(mockGoogleSignIn.disconnect()).called(1);
    expect(googleAuthService.hasSignedOut, true);
    verify(mockLocationListener.closeListener()).called(1);
  });
}

MyUser defaultUser() {
  return MyUser(
    email: 'email',
    name: 'name',
    imageUrl: "imageUrl",
    id: 'id',
    onboardingCompleted: true,
    phone: 'phone',
    phonePrefix: 'prefix',
    shareLocationEnabled: true,
  );
}
