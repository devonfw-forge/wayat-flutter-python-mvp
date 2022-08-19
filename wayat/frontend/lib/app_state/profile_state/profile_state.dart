import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';
part 'profile_state.g.dart';

class ProfileState = _ProfileState with _$ProfileState;

abstract class _ProfileState with Store {
  ProfileService profileService = ProfileService();

  @observable
  bool isProfile = false;

  @observable
  bool isEditProfile = false;

  @observable
  bool isPreferences = false;

  @observable
  bool isFaqs = false;

  @observable
  bool isPrivacy = false;

  @observable
  bool isAccount = false;

  @observable
  bool isSaved = false;

  @action
  void setProfile(bool setProfile) {
    isProfile = setProfile;
  }

  @action
  void setEditProfile(bool setEditProfile) {
    isEditProfile = setEditProfile;
  }

  @action
  void setPreferences(bool setPreferences) {
    isPreferences = setPreferences;
  }

  @action
  void setFaqs(bool setFaqs) {
    isFaqs = setFaqs;
  }

  @action
  void setPrivacy(bool setPrivacy) {
    isPrivacy = setPrivacy;
  }

  @action
  void setProfileSaved(bool isSaved) {
    isSaved = true;
  }

  Future updateCurrentUser() async {
    GetIt.I.get<SessionState>().updateCurrentUser();
  }
}
