import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';
import 'package:wayat/services/authentication/gphone_service_impl.dart';
import 'package:wayat/services/authentication/phone_service.dart';

part 'session_state.g.dart';

class SessionState = _SessionState with _$SessionState;

abstract class _SessionState with Store {

  @observable
  bool finishLoggedIn = false;

  @observable
  bool googleSignedIn = false;

  @observable
  bool phoneValidation = false;

  @observable
  bool hasDoneOnboarding = false;

  final AuthService _authService = GoogleAuthService();
  AuthService get authService => _authService;
  
  final PhoneService _phoneService = GooglePhoneService();
  PhoneService get phoneService => _phoneService;

  @action
  void doneOnBoarding() {
    hasDoneOnboarding = true;
  }

  @action
  void setGoogleSignIn(bool signedIn) {
    googleSignedIn = signedIn;
  }

  @action
  void setPhoneValidation(bool phoneValidated) {
    phoneValidation = phoneValidated;
  }

  @action
  void setFinishLoggedIn(bool finishedLoggedIn) {
    finishLoggedIn = finishedLoggedIn;
  }

  @action
  Future<void> googleLogin () async {
    GoogleAuthService googleAuth = (authService as GoogleAuthService);
    if (await googleAuth.signIn() != null) {
      setGoogleSignIn(true);
      //if (await googleAuth.hasPhoneNumber()) {
      //  setPhoneValidation(true);
      //}
    }
  }
}
