import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';
import 'package:mobx/mobx.dart';

part 'edit_profile_controller.g.dart';

// ignore: library_private_types_in_public_api
class EditProfileController = _EditProfileController
    with _$EditProfileController;

abstract class _EditProfileController with Store {
  /// Get current user state from FireStore
  final MyUser user = GetIt.I.get<SessionState>().currentUser!;

  /// Get profile state
  final ProfileState profileState = GetIt.I.get<ProfileState>();

  /// Initialize profile service
  ProfileServiceImpl profileService = ProfileServiceImpl();

  /// Observalbe variable [name], which uses in change name function
  @observable
  String? name;

  /// Observable variable [currentSelectedImage], which uses in change user image
  @observable
  XFile? currentSelectedImage;

  /// If [validPhone] is true, phone validation is successfull, if - false, phone verification is failed
  @observable
  bool validPhone = false;

  /// Set user name to new [newName]
  @action
  void setName(String newName) {
    name = newName;
  }

  /// Set user image to new [image]
  @action
  void setNewImage(XFile? image) {
    currentSelectedImage = image;
  }

  /// Back button to redirect from chiled pages [EditProfile] or [Preferences] to parent page [Profile]
  void onPressedBackButton() {
    profileState.setCurrentPage(ProfileCurrentPages.profile);
  }

  /// Update user changes name and/or image and/or phone number
  Future<void> onPressedSaveButton(String phoneNumber) async {
    /// Go back from EditProfile page to Profile page
    profileState.setCurrentPage(ProfileCurrentPages.profile);

    /// Validate new name and call [updateCurrentUserName] to save changes
    if (name != null ? name!.replaceAll(" ", "").isNotEmpty : false) {
      await profileState.updateCurrentUserName(name!);
    }

    /// Check new image is not null and call [updateUserImage] to save changes
    if (currentSelectedImage != null) {
      await profileState.updateUserImage(currentSelectedImage!);
    }

    /// Check new phone number not null and call [updatePhone] to save changes
    if (phoneNumber.isNotEmpty) {
      await GetIt.I.get<SessionState>().updatePhone(phoneNumber);
    }
  }

  /// Get new image from [sourse] pick it and call [setNewImage] to set changes
  Future getFromSource(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setNewImage(newImage);
  }
}
