import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';

class EditProfileController {
  final ProfileState profileState = GetIt.I.get<ProfileState>();

  ProfileServiceImpl profileService = ProfileServiceImpl();

  EditProfileController();

  void onPressedBackButton() {
    profileState.setCurrentPage(ProfileCurrentPages.profile);
  }

  Future<void> onPressedSaveButton(XFile? currentSelectedImage) async {
    onPressedBackButton();

    String name = GetIt.I.get<SessionState>().currentUser!.name;

    if (name != "") {
      await profileState.updateCurrentUserName(name);
    }

    if (currentSelectedImage != null) {
      await profileState.updateUserImage(currentSelectedImage);
    }
  }
}
