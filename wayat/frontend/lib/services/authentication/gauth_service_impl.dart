import 'package:get_it/get_it.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';

class GoogleAuthService implements AuthService {
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  late GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleAuthService({GoogleSignIn? gS}) {
    if (gS != null) _googleSignIn = gS;
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

  /// *Sign out* the current user.
  @override
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
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
