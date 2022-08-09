import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/user/user.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';
import 'package:wayat/services/authentication/gphone_service_impl.dart';

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

  @observable
  User currentUser = User(id: "", name: "", email: "", imageUrl: "", phone: "");

  final AuthService _authService = GoogleAuthService();
  AuthService get authService => _authService;

  final GooglePhoneService _phoneService = GooglePhoneService();
  GooglePhoneService get phoneService => _phoneService;

  String phoneNumber = "";

  @action
  void doneOnBoarding() {
    authService.updateOnboarding();
    hasDoneOnboarding = true;
  }

  Future<bool> isLogged() async {
    final logged = await authService.signInSilently();
    return logged != null;
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
  Future<void> googleLogin() async {
    GoogleAuthService googleAuth = (authService as GoogleAuthService);
    GoogleSignInAccount? gaccount = await googleAuth.signIn();
    if (gaccount != null) {
      currentUser = User(
          id: gaccount.id,
          name: gaccount.displayName ?? "",
          email: gaccount.email,
          imageUrl: gaccount.photoUrl ?? "",
          phone: "");
      await finishLoginProcess(googleAuth);
    }
  }

  @action
  Future<void> finishLoginProcess(GoogleAuthService googleAuth) async {
    setGoogleSignIn(true);
    if (await googleAuth.hasPhoneNumber()) {
      setPhoneValidation(true);
      setFinishLoggedIn(true);
      if (await googleAuth.isOnboardingCompleted()) {
        doneOnBoarding();
      }
    }
  }
}
