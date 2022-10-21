import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/lifecycle_state/lifecycle_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';
import 'package:wayat/services/profile/profile_service.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';
part 'user_state.g.dart';

/// Manages all the states for the authenticated user related
/// functionality.
///
/// Also, it wraps the authentication service.
// ignore: library_private_types_in_public_api
class UserState = _UserState with _$UserState;

abstract class _UserState with Store {
  GoogleSignInAccount? googleAccount;

  /// Instance of the authenticated user in the app.
  ///
  /// It will be `null` if there is no authenticated user.
  @observable
  MyUser? currentUser;

  /// Authentication service, useful for signing in an user
  /// (this includes signing silently), signing out an user and
  /// fetching authenticated user data, setting authenticated user data.
  final AuthService authService;

  final ProfileService _profileService;

  /// App state for the user session related functionality.
  ///
  /// If no [authService] is provided, a [GoogleAuthService]
  /// will be instantiated.
  _UserState({AuthService? authService, ProfileService? profileService})
      : authService = authService ?? GoogleAuthService(),
        _profileService = profileService ?? ProfileServiceImpl();

  /// Shows the graphical interface to login an user and
  /// proceeds with the login process.
  @action
  Future<void> login() async {
    googleAccount = await authService.signIn();
    // googleAccount will be null if the user cancels the google authentication
    if (googleAccount != null) {
      await initializeCurrentUser();
    }
  }

  /// Log out process. This includes closing the map,
  /// undoing changes in the login state and calling the
  /// [authService] [signOut].
  @action
  Future<void> logOut() async {
    final LifeCycleState lifeCycleState = GetIt.I.get<LifeCycleState>();
    await lifeCycleState.notifyAppClosed();

    await authService.signOut();
    // This needs to be after [signOut] to not navigate to the login page
    // before doing the sign out completely
    currentUser = null;
    googleAccount = null;
  }

  /// Checks if login process can be done without a
  /// graphical interface.
  ///
  /// If this functions ends and
  /// or [googleAccount] remains `null`, it means the user
  /// could not be authenticated silently.
  Future<bool> isLogged() async {
    if (currentUser != null) return true;
    googleAccount = await authService.signInSilently();
    return googleAccount != null;
  }

  @action
  Future<void> initializeCurrentUser() async {
    currentUser ??= await authService.getUserData();
    GetIt.I.get<LifeCycleState>().notifyAppOpenned();
  }

  /// Updates the [phone] of the authenticated user.
  ///
  /// Returns `true` if the `phone` has benn successfully
  /// updated.
  @action
  Future<bool> updatePhone(String prefix, String phone) async {
    bool done = await authService.sendPhoneNumber(prefix, phone);
    if (done) currentUser!.phone = phone;
    return done;
  }

  /// Update user profile image from [newImage]
  Future<void> updateImage(XFile newImage) async {
    await _profileService.uploadProfileImage(newImage);
    currentUser = await authService.getUserData();
  }

  /// Update current user profile name from [newName]
  @action
  Future<void> updateUserName(String newName) async {
    _profileService.updateProfileName(newName);
    currentUser!.name = newName;
  }

  /// Delete current user
  @action
  Future<void> deleteUser() async {
    _profileService.deleteCurrentUser();
  }
}
