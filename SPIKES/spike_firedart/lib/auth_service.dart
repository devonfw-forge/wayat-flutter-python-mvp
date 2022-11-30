import 'package:google_sign_in/google_sign_in.dart';

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
}
