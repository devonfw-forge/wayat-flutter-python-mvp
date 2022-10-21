import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/common/widgets/phone_verification/phone_verification_controller.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/common/app_config/env_model.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wayat/domain/user/my_user_factory.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Implementation of the Authentication Service using Google Authentication
class GoogleAuthService implements AuthService {
  /// Handles the requests to the server
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  /// Service to login in with Google and obtain the user's data and token
  @visibleForTesting
  late GoogleSignIn googleSignIn;

  /// Whether the user has signed out from this account in this current session.
  ///
  /// This is necessary because the method [signInSilently] can reAuthenticate
  /// even with the argument reAuthenticate to `true` (which is in fact, the default).
  /// This is even mentioned in the documentation for said method.
  bool hasSignedOut = false;

  /// Instance of the authentication service for Firebase
  final FirebaseAuth _auth;

  GoogleAuthService(
      {GoogleSignIn? gS, PlatformService? platformService, FirebaseAuth? auth})
      : _auth = auth ??
            FirebaseAuth.instanceFor(
                app: Firebase.app(EnvModel.FIREBASE_APP_NAME)) {
    if (gS != null) {
      googleSignIn = gS;
    } else {
      platformService ??= PlatformService();
      if (platformService.isWeb) {
        googleSignIn = GoogleSignIn(
          clientId: EnvModel.WEB_CLIENT_ID,
          scopes: ['email'],
        );
      } else {
        googleSignIn = GoogleSignIn(
          scopes: ['email'],
        );
      }
    }
  }

  /// Google *sign in* process. Returns ```null``` if no account is retrieved
  /// or something when wrong during the sign in process
  @override
  Future<GoogleSignInAccount?> signIn() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) return null;
      GoogleSignInAuthentication gauth = await account.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken,
        idToken: gauth.idToken,
      );
      await _auth.signInWithCredential(credential);
      if (_auth.currentUser == null) return null;
      return account;
    } on PlatformException {
      return null;
    }
  }

  /// Gets backend data of the current signed in user
  @override
  Future<MyUser> getUserData() async {
    final Map<String, dynamic> user =
        await httpProvider.sendGetRequest(APIContract.userProfile);
    return MyUserFactory.fromMap(user);
  }

  /// Refresh the **account id token**
  ///
  /// Returns an empty string if there is no authenticated user
  @override
  Future<String> getIdToken() async {
    if (_auth.currentUser == null) return "";
    return await _auth.currentUser!.getIdToken();
  }

  @override
  Future<GoogleSignInAccount?> signInSilently() async {
    if (hasSignedOut) {
      hasSignedOut = false;
      return null;
    }
    final GoogleSignInAccount? account =
        await googleSignIn.signInSilently(reAuthenticate: false);
    if (account == null) return null;
    GoogleSignInAuthentication gauth = await account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );
    await _auth.signInWithCredential(credential);
    if (_auth.currentUser == null) return null;
    return account;
  }

  /// Sign out the current user.
  /// Resets all the state after closing the firestore instance
  @override
  Future<void> signOut() async {
    GetIt.I.get<LocationListener>().closeListener();
    await _auth.signOut();
    await googleSignIn.disconnect();
    hasSignedOut = true;

    // ResetSingleton instances to reset any information for the current user
    //The only one not being reseted is LangSingleton
    GetIt.I.resetLazySingleton<PhoneVerificationController>();
    GetIt.I.resetLazySingleton<OnboardingController>();
    GetIt.I.resetLazySingleton<ContactsPageController>();
    GetIt.I.resetLazySingleton<LifeCycleState>();
    GetIt.I.resetLazySingleton<HomeNavState>();
    GetIt.I.resetLazySingleton<HttpProvider>();
    GetIt.I.resetLazySingleton<GroupsController>();
    GetIt.I.resetLazySingleton<LocationListener>();
  }

  @override
  Future<bool> sendPhoneNumber(String prefix, String phone) async {
    return (await httpProvider.sendPostRequest(APIContract.userProfile,
                    {"phone": phone, "phone_prefix": prefix}))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> sendDoneOnboarding() async {
    return (await httpProvider.sendPostRequest(
                    APIContract.userProfile, {"onboarding_completed": true}))
                .statusCode /
            10 ==
        20;
  }
}
