import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'dart:io';
import 'package:wayat/services/request/request_service.dart';

class GoogleAuthService extends AuthService {

  late GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );
  String? _idToken;
  late String _baseUrl;

  GoogleAuthService({GoogleSignIn? gS}) {
    if (Platform.isAndroid) {
      _baseUrl = FlutterConfig.get('ANDROID_BASE_URL')!;
    } else {
      _baseUrl = FlutterConfig.get('BASE_URL')!;
    }
    if (gS != null) _googleSignIn = gS;
  }

  @override
  Future<GoogleSignInAccount?> signIn() async {
    try{
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return null;
      _idToken = (await account.authentication).idToken;
      return account;
    } on PlatformException {return null;}
  }

  @override
  Future<bool> hasPhoneNumber() async {
    RequestService requestService = GetIt.I.get<RequestService>();
    // Gets backend data of the signed in user
    final Map<String, dynamic> user = await requestService.sendGetRequest("users/profile");
    if (!user.containsKey("phone_number") || user["phone_number"] == null) return false;
    return true;
  }

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

  @override
  Future<void> refreshIdToken() async {
    // By signing in silently (no interaction) it will get auth params 
    // including an idToken
    final GoogleSignInAccount? account = await _googleSignIn.signInSilently();
    if (account == null) throw Exception("No account signed in");
    _idToken = (await account.authentication).idToken;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _idToken = "";
  }
}