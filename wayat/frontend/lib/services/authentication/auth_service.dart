import 'package:google_sign_in/google_sign_in.dart';
import 'package:wayat/domain/user/my_user.dart';

/// Manages the authentication for users using Firebase and Google
abstract class AuthService {
  /// *Sign in* process.
  ///
  /// Returns the user's Google Account data
  Future<GoogleSignInAccount?> signIn();

  /// Returns the **account ID token**.
  Future<String> getIdToken();

  /// *Signs out* the current user.
  Future<void> signOut();

  /// Returns the current user account.
  Future<MyUser> getUserData();

  /// Tries to log in to see if an account already exists.
  ///
  /// Returns the user's Google Account data
  Future<GoogleSignInAccount?> signInSilently();

  /// Sends the phone number to the server to be verified.
  ///
  /// Returns whether the request was succesful
  Future<bool> sendPhoneNumber(String phone);

  /// Sends to the server that the user has done the onBoarding process
  ///
  /// Returns whether the request was succesful
  Future<void> sendDoneOnboarding();
}
