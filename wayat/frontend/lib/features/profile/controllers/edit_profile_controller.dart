import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';
import 'package:mobx/mobx.dart';

part 'edit_profile_controller.g.dart';

// ignore: library_private_types_in_public_api
class EditProfileController = _EditProfileController
    with _$EditProfileController;

abstract class _EditProfileController with Store {
  /// Reference to the current user

  final UserState userState = GetIt.I.get<UserState>();

  /// Instance of the profile service
  ProfileServiceImpl profileService = ProfileServiceImpl();

  /// Observable variable [name], used when updating the username
  @observable
  String? name;

  /// Observable variable [currentSelectedImage], used when changing the profile picture
  @observable
  XFile? currentSelectedImage;

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

  /// Saves all the updates to the user's profile
  Future<void> onPressedSaveButton() async {
    /// Validate new name and call [updateCurrentUserName] to save changes
    if (name != null ? name!.replaceAll(" ", "").isNotEmpty : false) {
      await userState.updateUserName(name!);
    }

    /// Check new image is not null and call [updateUserImage] to save changes
    if (currentSelectedImage != null) {
      await userState.updateImage(currentSelectedImage!);
    }
  }

  /// Get new image from [sourse] pick it and call [setNewImage] to set changes
  Future getFromSource(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setNewImage(newImage);
  }
}
