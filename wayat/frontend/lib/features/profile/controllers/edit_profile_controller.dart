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
  final MyUser user = GetIt.I.get<SessionState>().currentUser!;
  final ProfileState profileState = GetIt.I.get<ProfileState>();

  ProfileServiceImpl profileService = ProfileServiceImpl();

  @observable
  String? name;

  @observable
  XFile? currentSelectedImage;

  @observable
  bool validPhone = false;

  @action
  void setName(String newName) {
    name = newName;
  }

  @action
  void setNewImage(XFile? image) {
    currentSelectedImage = image;
  }

  void onPressedBackButton() {
    profileState.setCurrentPage(ProfileCurrentPages.profile);
  }

  Future<void> onPressedSaveButton(String phoneNumber) async {
    profileState.setCurrentPage(ProfileCurrentPages.profile);
    if (name != null ? name!.replaceAll(" ", "").isNotEmpty : false) {
      await profileState.updateCurrentUserName(name!);
    }

    if (currentSelectedImage != null) {
      await profileState.updateUserImage(currentSelectedImage!);
    }
    if (phoneNumber.isNotEmpty) {
      await GetIt.I.get<SessionState>().updatePhone(phoneNumber);
    }
  }

  Future getFromSource(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setNewImage(newImage);
  }
}
