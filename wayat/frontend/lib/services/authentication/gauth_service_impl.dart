import 'package:wayat/domain/user/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wayat/services/api_contract/api_contract.dart';
import 'package:wayat/services/authentication/auth_service.dart';

class GoogleAuthService extends AuthService {
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
        await super.sendGetRequest(APIContract.userProfile);
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
}
