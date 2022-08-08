import 'package:wayat/services/request/request_service.dart';

abstract class AuthService extends RequestService {

  /// *Sign in* process
  Future<dynamic> signIn();

  /// Returns the **account id token**
  Future<String> getIdToken();

  /// *Sign out* the current user
  Future<void> signOut();
  
  /// Checks if the current user has a phone number
  Future<bool> hasPhoneNumber();

  Future<bool> isOnboardingCompleted();

  Future<bool> updatePhone(String phone);

  /// Sets onboarding as done for the current user
  Future<bool> updateOnboarding();

  Future<dynamic> signInSilently();
}