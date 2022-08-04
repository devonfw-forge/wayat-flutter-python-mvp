import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:wayat/services/authentication/auth_service.dart';

class GoogleAuthService extends AuthService {

  late GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );
  String? _idToken;

  GoogleAuthService({GoogleSignIn? gS}) {
    if (gS != null) _googleSignIn = gS;
  }

  /// Google *sign in* process
  @override
  Future<GoogleSignInAccount?> signIn() async {
    try{
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return null;
      _idToken = (await account.authentication).idToken;
      return account;
    } on PlatformException {return null;}
  }

  /// Checks if the current user has a phone number, sending a **GET** 
  /// request to the *backend* service 
  @override
  Future<bool> hasPhoneNumber() async {
    // Gets backend data of the signed in user
    final Map<String, dynamic> user = await super.sendGetRequest("users/profile");
    if (!user.containsKey("phone_number") || user["phone_number"] == null) return false;
    return true;
  }


  /// Refresh the **account id token**
  /// 
  /// Throws on [Exception] if there is no authenticated user
  @override
  Future<String> getIdToken() async {
    if (_idToken == null || DateTime.now().isAfter(_getTokenExpirationTime(_idToken!))) {
      refreshIdToken();
    }
    return _idToken!;
  }

  DateTime _getTokenExpirationTime(String token) {
    return Jwt.getExpiryDate(token) ?? DateTime.now();
  }

  /// Refresh the google **account id token**
  @override
  Future<void> refreshIdToken() async {
    // By signing in silently (no interaction) it will get auth params 
    // including an idToken
    final GoogleSignInAccount? account = await _googleSignIn.signInSilently();
    if (account == null) throw Exception("No account signed in");
    _idToken = (await account.authentication).idToken;
  }

  /// *Sign out* the current user.
  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _idToken = "";
  }
}