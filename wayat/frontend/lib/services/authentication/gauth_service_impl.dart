import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:wayat/services/authentication/gauth_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wayat/services/request/request_service.dart';

class GoogleAuthServiceImpl extends GoogleAuthService {

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );
  String? _idToken;
  late String _baseUrl;

  GoogleAuthServiceImpl() {
    if (Platform.isAndroid) {
      _baseUrl = dotenv.get('ANDROID_URL_PREFIX');
    } else {
      _baseUrl = dotenv.get('URL_PREFIX');
    }
  }

  @override
  Future<GoogleSignInAccount?> signInGoogle() async {
    try{
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return null;
      _idToken = (await account.authentication).idToken;
      return account;
    } on PlatformException {return null;}
  }

  Future<bool> hasPhoneNumber() async {
    RequestService requestService = GetIt.I.get<RequestService>();
    // Gets backend data of the signed in user
    final Map<String, dynamic> user = await requestService.sendGetRequest("user");
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
  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    _idToken = "";
  }
}