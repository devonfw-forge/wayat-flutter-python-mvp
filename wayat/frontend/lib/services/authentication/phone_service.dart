import 'package:wayat/services/service.dart';

abstract class PhoneService extends Service {
  
  /// Wait for an SMS code to be sent
  Future<void> sendSMSCode(String phoneNumber);

  /// Verify the SMS code sent to the user
  Future<bool> verifySMSCode(String smsCode);
}