import 'package:wayat/services/service.dart';

abstract class AuthService extends Service {

  /// *Sign in* process.
  Future<dynamic> signIn();

  /// Returns the **account id token**.
  Future<String> getIdToken();
  
  /// Refresh the **account id token**.
  /// 
  /// Throws on [Exception] if there is no authenticated user.
  Future<void> refreshIdToken();

  /// *Sign out* the current user.
  Future<void> signOut();
  
  /// Checks if the current user has a phone number
  Future<bool> hasPhoneNumber();
}