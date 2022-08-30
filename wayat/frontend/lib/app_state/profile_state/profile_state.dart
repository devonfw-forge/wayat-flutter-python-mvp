import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/features/profile/selector/profile_pages.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';
part 'profile_state.g.dart';

// ignore: library_private_types_in_public_api
class ProfileState = _ProfileState with _$ProfileState;

abstract class _ProfileState with Store {
  final ProfileService _profileService = ProfileService();

  @observable
  ProfilePages currentPage = ProfilePages.profile;

  @observable
  bool isAccount = false;

  @observable
  bool isSaved = false;

  @action
  void setCurrentPage(ProfilePages newPage) {
    currentPage = newPage;
  }

  @action
  void setProfileSaved(bool isSaved) {
    isSaved = true;
  }

  @action
  Future updateCurrentUser() async {
    GetIt.I.get<SessionState>().updateCurrentUser();
  }

  Future updateUserImage(XFile newImage) async {
    await _profileService.uploadProfileImage(newImage);
    await updateCurrentUser();
  }

  @action
  Future updateCurrentUserName(String newName) async {
    _profileService.updateProfileName(newName);
    GetIt.I.get<SessionState>().currentUser!.name = newName;
  }

  @action
  Future deleteCurrentUser(String id) async {
    _profileService.deleteCurrentUser(id);
  }
}
