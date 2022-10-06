import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/features/profile/controllers/profile_controller.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';
import 'package:mobx/mobx.dart';

part 'edit_profile_controller.g.dart';

// ignore: library_private_types_in_public_api
class EditProfileController = _EditProfileController
    with _$EditProfileController;

abstract class _EditProfileController with Store {
  /// Reference to the current user

  final UserState userState = GetIt.I.get<UserState>();

  /// Reference to the profile state
  final ProfileController profileController = GetIt.I.get<ProfileController>();

  /// Instance of the profile service
  ProfileServiceImpl profileService = ProfileServiceImpl();

  /// Observable variable [name], used when updating the username
  @observable
  String? name;

  /// Observable variable [currentSelectedImage], used when changing the profile picture
  @observable
  XFile? currentSelectedImage;

  /// Whether the proccess of validating the phone is successful
  @observable
  bool validPhone = false;

  /// Sets user name to new [newName]
  @action
  void setName(String newName) {
    name = newName;
  }

  /// Sets user image to new [image]
  @action
  void setNewImage(XFile? image) {
    currentSelectedImage = image;
  }

  /// Returns from the child pages [EditProfile] or [Preferences] to the parent page [Profile]
  void onPressedBackButton() {
    profileController.currentPage = ProfileCurrentPages.profile;
  }

  /// Saves all the updates to the user's profile
  Future<void> onPressedSaveButton(String phoneNumber) async {
    /// Go back from EditProfile page to Profile page
    profileController.currentPage = ProfileCurrentPages.profile;

    /// Validate new name and call [updateCurrentUserName] to save changes
    if (name != null ? name!.replaceAll(" ", "").isNotEmpty : false) {
      await userState.updateUserName(name!);
    }

    /// Check new image is not null and call [updateUserImage] to save changes
    if (currentSelectedImage != null) {
      await userState.updateImage(currentSelectedImage!);
    }

    /// Check new phone number not null and call [updatePhone] to save changes
    if (phoneNumber.isNotEmpty) {
      await userState.updatePhone(phoneNumber);
    }
  }

  /// Get new image from [sourse] pick it and call [setNewImage] to set changes
  Future getFromSource(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setNewImage(newImage);
  }
}
