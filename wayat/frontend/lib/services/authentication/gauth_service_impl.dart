import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:wayat/services/authentication/gauth_service.dart';

class GoogleAuthServiceImpl extends GoogleAuthService {

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _idToken;
  String _verificationId = "";

  @override
  Future<GoogleSignInAccount?> signInGoogle() async {
    try{
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return null;
      _idToken = (await account.authentication).idToken;
      return account;
    } on PlatformException {return null;}
  }

  DateTime _getTokenExpirationTime(String token) {
    return Jwt.getExpiryDate(token) ?? DateTime.now();
  }

  @override
  Future<String?> getIdToken() async {
    if (_idToken == null || DateTime.now().isAfter(_getTokenExpirationTime(_idToken!))) {
      refreshIdToken();
    }
    return _idToken;
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
  }

  @override
  Future<void> sendSMSCode(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  @override
  Future<bool> verifySMSCode(String smsCode) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    try{
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if(e.code == 'invalid-verification-code'){
        return false;
      }
      rethrow;
    }
    return true;
  }

  void _onVerificationCompleted(PhoneAuthCredential authCredential) async {}

  void _onVerificationFailed(FirebaseAuthException exception) {
    // Posible code exception: 'invalid-phone-number'
    throw exception;
  }

  void _onCodeSent(String verificationId, int? forceResendingToken) {
    _verificationId = verificationId;
  }

  void _onCodeTimeout(String timeout) {
    // TODO on code timeout it should open a dialog and resend an sms codes
  }
}