import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/user/my_user.dart';
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

  @observable
  MyUser? currentUser;

  final AuthService _authService = GoogleAuthService();
  AuthService get authService => _authService;

  @action
  Future<void> doneOnBoarding() async {
    await updateOnboarding();
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
  Future<void> setFinishLoggedIn(bool finishedLoggedIn) async {
    googleSignedIn = finishedLoggedIn;
    finishLoggedIn = finishedLoggedIn;
  }

  @action
  Future<void> updateCurrentUser() async {
    currentUser ??= await authService.getUserData();
  }

  @action
  Future<bool> updatePhone(String phone) async {
    bool done = (await authService.sendPostRequest("users/profile", {"phone": phone}))
      .statusCode / 10 == 20;
    if (done) currentUser!.phone = phone;
    return done;
  }

  @action
  Future<bool> updateOnboarding() async {
    bool done = (await authService.sendPostRequest(
      "users/profile", {"onboarding_completed": true}))
      .statusCode / 10 == 20;
    if (done) currentUser!.onboardingCompleted = true;
    return done;
  }

  Future<void> doLoginProcess() async {
    setGoogleSignIn(true);
    await updateCurrentUser();
    if (await hasPhoneNumber()) {
      await setFinishLoggedIn(true);
      if (await isOnboardingCompleted()) {
        await doneOnBoarding();
      }
    }
  }

  Future<void> login() async {
    GoogleSignInAccount? gaccount = await authService.signIn();
    if (gaccount != null) {
      await doLoginProcess();
    }
  }

  Future<bool> hasPhoneNumber() async {
    // Gets backend data of the signed in user if it is null
    if (currentUser!.phone == "") {
      return false;
    }
    return true;
  }

  Future<bool> isOnboardingCompleted() async {
    // Gets backend data of the signed in user if it is null
    return currentUser!.onboardingCompleted;
  }
}
