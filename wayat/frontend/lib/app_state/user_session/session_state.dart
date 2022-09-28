import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/map_state/map_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';
part 'session_state.g.dart';

/// Manages all the states for the athenticad user related
/// functionality. 
/// 
/// Also, it wraps the authentication service. 
// ignore: library_private_types_in_public_api
class SessionState = _SessionState with _$SessionState;

abstract class _SessionState with Store {
  /// Whether or not the authentication process has been completed.
  /// 
  /// Useful for **auto_route**.
  @observable
  bool finishLoggedIn = false;

  /// Whether or not the user has logged in with google.
  /// 
  /// Useful for **auto_route**.
  @observable
  bool googleSignedIn = false;

  /// Wheter or not the user has finished the onboarding process.
  ///
  /// Useful for **auto_route**.
  @observable
  bool hasDoneOnboarding = false;

  /// Instance of the authenticated user in the app.
  /// 
  /// It will be `null` if there is no authenticated user.
  @observable
  MyUser? currentUser;

  /// Authentication service, useful for signing in an user 
  /// (this includes signing silently), signing out an user and
  /// fetching authenticated user data, setting authenticated user data.
  final AuthService authService;

  /// App state for the user session related functionality.
  /// 
  /// If no [authService] is provided, a [GoogleAuthService]
  /// will be instantiated.
  _SessionState({AuthService? authService})
      : authService = authService ?? GoogleAuthService();

  /// Calls [setDoneOnBoarding] function and then it changes 
  /// the state of `hasDoneOnboarding` to `true`.
  @action
  Future<void> doneOnBoarding() async {
    await setDoneOnBoarding();
    hasDoneOnboarding = true;
  }

  /// Checks if login process can be done without a
  /// graphical interface.
  /// 
  /// If this functions ends and [currentUser] remains `null`
  /// or [googleSignedIn] remains `false`, it means the user 
  /// could not be authenticated silently.
  Future<void> isLogged() async {
    if (currentUser != null) return;
    if (!googleSignedIn) {
      GoogleSignInAccount? account = await authService.signInSilently();
      if (account != null) {
        await doLoginProcess();
      }
    }
  }

  /// Changes the state of [googleSignedIn].
  @action
  void setGoogleSignIn(bool signedIn) {
    if (googleSignedIn != signedIn) {
      googleSignedIn = signedIn;
    }
  }

  /// Changes the state of [finishLoggedIn].
  @action
  void setFinishLoggedIn(bool finishedLoggedIn) {
    finishLoggedIn = finishedLoggedIn;
  }

  /// Fetches all authenticated user data.
  /// 
  /// Only if the user has not been initialized yet.
  @action
  Future initializeUser() async {
    currentUser ??= await authService.getUserData();
  }

  /// Fetches and overrides all authenticated user data.
  @action
  Future updateCurrentUser() async {
    currentUser = await authService.getUserData();
  }

  /// Updates the [phone] of the authenticated user.
  /// 
  /// Returns `true` if the `phone` has benn successfully 
  /// updated.
  @action
  Future<bool> updatePhone(String phone) async {
    bool done = await authService.sendPhoneNumber(phone);
    if (done) currentUser!.phone = phone;
    return done;
  }

  /// Updates the [onboardingCompleted] of the 
  /// authenticated user to `true`.
  /// 
  /// Returns `true` if the [onboardingCompleted] has benn 
  /// successfully updated.
  @action
  Future<bool> setDoneOnBoarding() async {
    bool done = await authService.sendDoneOnboarding(true);
    if (done) currentUser!.onboardingCompleted = true;
    return done;
  }

  /// Fetches user data and finishes the
  /// login process if the phone has been set.
  Future doLoginProcess() async {
    if (!googleSignedIn) {
      await initializeUserSession();
      if (currentUser!.phone != "") {
        setFinishLoggedIn(true);
      }
    }
  }

  /// Sets the state to signed in and intializes the
  /// authenticated user.
  Future initializeUserSession() async {
    setGoogleSignIn(true);
    await initializeUser();
    hasDoneOnboarding = currentUser!.onboardingCompleted;
  }

  /// Shows the graphical interface to login an user and
  /// proceeds with the login process.
  Future<void> login() async {
    GoogleSignInAccount? gaccount = await authService.signIn();
    if (gaccount != null) {
      await doLoginProcess();
      return;
    }
  }

  /// Log out process. This includes closing the map, 
  /// undoing changes in the login state and calling the 
  /// [authService] [signOut].
  Future logOut() async {
    final MapState mapState = GetIt.I.get<MapState>();
    await mapState.closeMap();
    finishLoggedIn = false;
    googleSignedIn = false;
    hasDoneOnboarding = false;

    await authService.signOut();
    currentUser = null;
  }

  /// Checks if the onboarding process has been 
  /// completed.
  bool isOnboardingCompleted() {
    return currentUser!.onboardingCompleted;
  }

  /// Checks if the authenticated user has a 
  /// phone number.
  bool hasPhone() {
    return currentUser != null && currentUser!.phone != "";
  }
}
