import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/home_state/home_state.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/map_state/map_state.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      FirebaseAuth.instanceFor(app: Firebase.app('WAYAT'));

  GoogleAuthService({GoogleSignIn? gS}) {
    if (gS != null) {
      _googleSignIn = gS;
    } else {
      if (PlatformService().isWeb) {
        _googleSignIn = GoogleSignIn(
          clientId: dotenv.get('WEB_CLIENT_ID'),
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
    return MyUser.fromMap(user);
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
    await FirebaseFirestore.instanceFor(app: Firebase.app('WAYAT')).terminate();
    await _auth.signOut();
    await _googleSignIn.signOut();

    // ResetSingleton instances to reset any information for the current user
    GetIt.I.resetLazySingleton<OnboardingController>();
    GetIt.I.resetLazySingleton<ContactsPageController>();
    GetIt.I.resetLazySingleton<UserStatusState>();
    GetIt.I.resetLazySingleton<LocationState>();
    GetIt.I.resetLazySingleton<ProfileState>();
    GetIt.I.resetLazySingleton<MapState>();
    GetIt.I.resetLazySingleton<HomeState>();
    GetIt.I.resetLazySingleton<HttpProvider>();
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
  Future<bool> sendDoneOnboarding(bool doneOnboarding) async {
    return (await httpProvider.sendPostRequest(
                    APIContract.userProfile, {"onboarding_completed": true}))
                .statusCode /
            10 ==
        20;
  }
}
