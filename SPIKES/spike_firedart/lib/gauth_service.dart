import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';
import 'package:spike_firedart/auth_service.dart';
import 'package:spike_firedart/platform_service.dart';
import 'package:firebase_auth_desktop/firebase_auth_desktop.dart';
import 'dart:developer' as dev;

class GoogleAuthService implements AuthService {
  @visibleForTesting
  late GoogleSignIn googleSignIn;
  bool hasSignedOut = false;
  late final FirebaseAuthDesktop _auth;
  final PlatformService _platformService;

  GoogleAuthService(
      {GoogleSignIn? gS,
      FirebaseAuthDesktop? auth,
      PlatformService? platformService})
      : _platformService = platformService ?? PlatformService() {
    if (!_platformService.isDesktop) {
      _auth = auth ?? FirebaseAuthDesktop.instance;
    }
    if (gS != null) {
      googleSignIn = gS;
    } else {
      if (_platformService.isWeb) {
        googleSignIn = GoogleSignIn(
          clientId: dotenv.get('DESKTOP_CLIENT_ID'),
          scopes: ['email'],
        );
      } else if (_platformService.isDesktop) {
        GoogleSignInDart.register(clientId: dotenv.get('DESKTOP_CLIENT_ID'));
        googleSignIn = GoogleSignIn(
          clientId: dotenv.get('DESKTOP_CLIENT_ID'),
          scopes: ['email'],
        );
      } else {
        googleSignIn = GoogleSignIn(
          scopes: ['email'],
        );
      }
    }
  }

  @override
  Future<GoogleSignInAccount?> signIn() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) return null;
      GoogleSignInAuthentication gauth = await account.authentication;
      if (!_platformService.isDesktop) {
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken,
          idToken: gauth.idToken,
        );
        await _auth.signInWithCredential(credential);
        if (_auth.currentUser == null) return null;
      }
      dev.log('$account');
      return account;
    } on PlatformException {
      return null;
    }
  }

  @override
  Future<String> getIdToken() async {
    if (_platformService.isDesktop) return "";
    if (_auth.currentUser == null) return "";
    return await _auth.currentUser!.getIdToken(false);
  }

  Future<GoogleSignInAccount?> signInSilently() async {
    if (_platformService.isDesktop) return null;
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
    if (!_platformService.isDesktop) {
      await _auth.signInWithCredential(credential);
      if (_auth.currentUser == null) return null;
    }
    return account;
  }

  @override
  Future<void> signOut() async {
    _auth.signOut();
    await googleSignIn.disconnect();
    hasSignedOut = true;
  }
}
