import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/services/authentication/auth_service.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';
import 'dart:io' as io;
part 'profile_state.g.dart';

class ProfileState = _ProfileState with _$ProfileState;

abstract class _ProfileState with Store {
  final AuthService _authService = GoogleAuthService();
  AuthService get authService => _authService;

  @observable
  MyUser? currentUser;

  @observable
  bool isEditProfile = false;

  @observable
  bool isPreferences = false;

  @observable
  bool isFaqs = false;

  @observable
  bool isAccount = false;

  @observable
  bool isSaved = false;

  @action
  void setProfileSaved(bool isSaved) {
    if (!isSaved) {
      isSaved = true;
    }
  }

  @action
  Future updateCurrentUser() async {
    currentUser ??= await authService.getUserData();
  }

  @action
  Future<bool> uploadProfileImage(XFile? selectedImage) async {
    final bytes = await io.File(selectedImage!.path).readAsBytes();
    bool done = (await authService.sendPostMediaRequest(
                    "users/profile/picture", {"body": '$bytes'}))
                .statusCode /
            10 ==
        20;
    return done;
  }

  @action
  Future<bool> updateProfileName(String name) async {
    updateCurrentUser();
    bool done =
        (await authService.sendPostRequest("users/profile", {"name": name}))
                    .statusCode /
                10 ==
            20;
    if (done) currentUser!.name = name;
    return done;
  }
}
