import 'package:google_sign_in/google_sign_in.dart';
import 'package:wayat/domain/user/my_user.dart';

abstract class AuthService {
  /// *Sign in* process
  Future<GoogleSignInAccount?> signIn();

  /// Returns the **account id token**
  Future<String> getIdToken();

  /// *Sign out* the current user
  Future<void> signOut();

  Future<MyUser> getUserData();

  Future<GoogleSignInAccount?> signInSilently();

  Future<bool> sendPhoneNumber(String phone);

  Future<bool> sendDoneOnboarding(bool doneOnboarding);
}
