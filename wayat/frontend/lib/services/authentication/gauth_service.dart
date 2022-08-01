import 'package:google_sign_in/google_sign_in.dart';
import 'package:wayat/services/service.dart';

abstract class GoogleAuthService extends Service {

  /// *Sign in* using interactive widget.
  Future<GoogleSignInAccount?> signInGoogle();

  /// Returns the **account id token**.
  Future<String?> getIdToken();
  
  /// Refresh the **account id token** using the non intercative sign in.
  /// 
  /// Throws on [Exception] if there is no authenticated user.
  Future<void> refreshIdToken();

  /// *Sign out* the current user.
  Future<void> signOutGoogle();

  /// Wait for the user to complete the recaptcha and for an SMS code to be sent.\
  /// **This method updates the ```_verificationId```.** 
  /// #### Usage:
  /// ```
  /// GoogleAuthService auth = GoogleAuthService();
  /// /* Google sign in process, then: */
  /// await auth.sendSMSCode('+34612345678');
  /// ```
  /// #### Verify with: 
  /// ```
  /// await auth.verifySMSCode('123456');
  /// ```
  Future<void> sendSMSCode(String phoneNumber);

  /// Verify the SMS code sent to the user once the ```sendSMSCode``` is called.
  Future<bool> verifySMSCode(String smsCode);
}