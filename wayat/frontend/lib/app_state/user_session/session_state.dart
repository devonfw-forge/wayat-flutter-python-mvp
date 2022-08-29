import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/api_contract/api_contract.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';
part 'session_state.g.dart';

// ignore: library_private_types_in_public_api
class SessionState = _SessionState with _$SessionState;

abstract class _SessionState with Store {
  @observable
  bool finishLoggedIn = false;

  @observable
  bool googleSignedIn = false;

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

  Future isLogged() async {
    if (!googleSignedIn) {
      GoogleSignInAccount? account = await authService.signInSilently();
      if (account != null) {
        await doLoginProcess();
      }
    }
  }

  @action
  void setGoogleSignIn(bool signedIn) {
    if (googleSignedIn != signedIn) {
      googleSignedIn = signedIn;
    }
  }

  @action
  void setFinishLoggedIn(bool finishedLoggedIn) {
    finishLoggedIn = finishedLoggedIn;
  }

  @action
  Future initializeUser() async {
    currentUser ??= await authService.getUserData();
  }

  @action
  Future updateCurrentUser() async {
    currentUser = await authService.getUserData();
  }

  @action
  Future<bool> updatePhone(String phone) async {
    bool done = (await authService
                    .sendPostRequest(APIContract.userProfile, {"phone": phone}))
                .statusCode /
            10 ==
        20;
    if (done) currentUser!.phone = phone;
    return done;
  }

  @action
  Future<bool> updateOnboarding() async {
    bool done = (await authService.sendPostRequest(
                    APIContract.userProfile, {"onboarding_completed": true}))
                .statusCode /
            10 ==
        20;
    if (done) currentUser!.onboardingCompleted = true;
    return done;
  }

  Future doLoginProcess() async {
    if (!googleSignedIn) {
      await initializeUserSession();
      if (currentUser!.phone != "") {
        setFinishLoggedIn(true);
      }
    }
  }

  /// Sets the state to signed in and retrieves the user
  /// from the server
  Future initializeUserSession() async {
    setGoogleSignIn(true);
    await initializeUser();
    hasDoneOnboarding = currentUser!.onboardingCompleted;
  }

  Future login() async {
    GoogleSignInAccount? gaccount = await authService.signIn();
    if (gaccount != null) {
      await doLoginProcess();

      return;
    }
  }

  Future logOut() async {
    authService.signOut();
  }

  bool isOnboardingCompleted() {
    // Gets backend data of the signed in user if it is null
    return currentUser!.onboardingCompleted;
  }

  bool hasPhone() {
    return currentUser != null && currentUser!.phone != "";
  }
}
