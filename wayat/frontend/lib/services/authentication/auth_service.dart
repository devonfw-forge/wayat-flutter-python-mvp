import 'package:google_sign_in/google_sign_in.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/request/rest_service.dart';

abstract class AuthService extends RESTService {
  /// *Sign in* process
  Future<GoogleSignInAccount?> signIn();

  /// Returns the **account id token**
  Future<String> getIdToken();

  /// *Sign out* the current user
  Future<void> signOut();

  Future<MyUser> getUserData();

  Future<GoogleSignInAccount?> signInSilently();
}
