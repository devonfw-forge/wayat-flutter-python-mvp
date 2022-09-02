import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';

class EditProfileController {
  final ProfileState profileState = GetIt.I.get<ProfileState>();

  ProfileServiceImpl profileService = ProfileServiceImpl();

  void onPressedBackButton() {
    profileState.setCurrentPage(ProfileCurrentPages.profile);
  }

  Future<void> onPressedSaveButton(
      String? name, XFile? currentSelectedImage) async {
    onPressedBackButton();

    if (name != null ? name.replaceAll(" ", "").isNotEmpty : false) {
      await profileState.updateCurrentUserName(name);
    }

    if (currentSelectedImage != null) {
      await profileState.updateUserImage(currentSelectedImage);
    }
  }
}
