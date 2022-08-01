import 'package:google_sign_in/google_sign_in.dart';
import 'package:wayat/services/service.dart';

abstract class GoogleAuthService extends Service {

  /// *Sign in* using interactive widget.
  Future<GoogleSignInAccount?> signInGoogle();

  /// Returns the **account id token**.
  Future<String> getIdToken();
  
  /// Refresh the **account id token** using the non intercative sign in.
  /// 
  /// Throws on [Exception] if there is no authenticated user.
  Future<void> refreshIdToken();

  /// *Sign out* the current user.
  Future<void> signOutGoogle();
}