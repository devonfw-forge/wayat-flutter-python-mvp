import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';

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
  //bool get isLoggedIn => token.isEmpty;

  final AuthService _authService = GoogleAuthService();
  AuthService get authService => _authService;

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
    if (await (authService as GoogleAuthService).signIn() != null) {
      setGoogleSignIn(true);
    }
  }
}
