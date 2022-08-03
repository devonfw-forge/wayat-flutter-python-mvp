import 'package:wayat/services/service.dart';

abstract class PhoneService extends Service {
  
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