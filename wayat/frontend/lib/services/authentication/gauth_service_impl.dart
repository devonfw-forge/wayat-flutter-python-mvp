import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/common/widgets/phoneVerificationField/phone_verification_controller.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/features/profile/controllers/profile_controller.dart';
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
  late GoogleSignIn _googleSignIn;

  /// Instance of the authentication service for Firebase
  final FirebaseAuth _auth =
      FirebaseAuth.instanceFor(app: Firebase.app(EnvModel.FIREBASE_APP_NAME));

  GoogleAuthService({GoogleSignIn? gS, PlatformService? platformService}) {
    if (gS != null) {
      _googleSignIn = gS;
    } else {
      platformService ??= PlatformService();
      if (platformService.isWeb) {
        _googleSignIn = GoogleSignIn(
          clientId: EnvModel.WEB_CLIENT_ID,
          scopes: ['email'],
        );
      } else {
        _googleSignIn = GoogleSignIn(
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
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
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
  /// Throws on [Exception] if there is no authenticated user
  @override
  Future<String> getIdToken() async {
    if (_auth.currentUser == null) return "";
    return await _auth.currentUser!.getIdToken();
  }

  @override
  Future<GoogleSignInAccount?> signInSilently() async {
    final GoogleSignInAccount? account = await _googleSignIn.signInSilently();
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
    await FirebaseFirestore.instanceFor(
            app: Firebase.app(EnvModel.FIREBASE_APP_NAME))
        .terminate();
    await _auth.signOut();
    await _googleSignIn.signOut();

    // ResetSingleton instances to reset any information for the current user
    GetIt.I.resetLazySingleton<PhoneVerificationController>();
    GetIt.I.resetLazySingleton<OnboardingController>();
    GetIt.I.resetLazySingleton<ContactsPageController>();
    GetIt.I.resetLazySingleton<ProfileController>();
    GetIt.I.resetLazySingleton<LifeCycleState>();
    GetIt.I.resetLazySingleton<HomeNavState>();
    GetIt.I.resetLazySingleton<HttpProvider>();
    GetIt.I.resetLazySingleton<GroupsController>();
    GetIt.I.resetLazySingleton<LocationListener>();
  }

  @override
  Future<bool> sendPhoneNumber(String phone) async {
    return (await httpProvider
                    .sendPostRequest(APIContract.userProfile, {"phone": phone}))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<void> sendDoneOnboarding() async {
    (await httpProvider.sendPostRequest(
                    APIContract.userProfile, {"onboarding_completed": true}))
                .statusCode /
            10 ==
        20;
  }
}
