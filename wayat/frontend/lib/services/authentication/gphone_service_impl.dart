import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';

class GooglePhoneService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = "";
  
  /// Wait for the user to complete the recaptcha and for an SMS code to be sent.\
  /// **This method updates the ```verificationId```.** 
  /// #### Usage:
  /// ```
  /// AuthService auth = GoogleAuthService();
  /// /* Google sign in process, then: */
  /// await auth.sendSMSCode('+34612345678');
  /// ```
  /// #### Verify with: 
  /// ```
  /// await auth.verifySMSCode('123456');
  /// ```
  /// ------------------------------------
  /// Throw [FirebaseAuthException] with ```invalid-phone-number``` code
  Future<void> sendGoogleSMSCode(
    {
      required String phoneNumber,
      void Function(FirebaseAuthException)? verificationFailed,
      void Function(String)? codeTimeout,
      void Function(String verificationId, int? forceResendingToken)? codeSent
    }
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: 
        verificationFailed ?? _onVerificationFailed,
      codeSent: codeSent ?? _onCodeSent,
      codeAutoRetrievalTimeout: 
        codeTimeout ?? _onCodeTimeout,
      //timeout: const Duration(seconds: 2*60)
    );
  }

  /// Verify the SMS code sent to the user, it should be called after
  /// the cade has been sent
  /// ------------------------------------
  /// Throw [FirebaseAuthException] with code :
  /// * ```invalid-verification-code``` if verification code is invalid
  /// * ```session-expired``` if timeout session has been reached 
  Future<void> verifyGoogleSMSCode(String smsCode) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await _auth.signInWithCredential(credential);
  }

  void _onVerificationCompleted(PhoneAuthCredential authCredential) async {}

  void _onVerificationFailed(FirebaseAuthException exception) {
    // Posible code exception: 'invalid-phone-number'
  }

  void _onCodeSent(String verificationId, int? forceResendingToken) {
    _verificationId = verificationId;
    // Proceed to SMS code validation
    GetIt.I.get<SessionState>().setPhoneValidation(true);
  }

  void _onCodeTimeout(String timeout) {}
}