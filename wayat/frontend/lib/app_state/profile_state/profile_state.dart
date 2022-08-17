import 'package:mobx/mobx.dart';
part 'profile_state.g.dart';

class ProfileState = _ProfileState with _$ProfileState;

abstract class _ProfileState with Store {
  @observable
  bool isEditProfile = false;

  @observable
  bool isPreferences = false;

  @observable
  bool isFaqs = false;

  @observable
  bool isTerms = false;

  @observable
  bool isProfile = false;

  @action
  void goToProfile(bool isProfile) {
    isProfile = true;
  }

  @action
  void goToEditProfile(bool isEditProfile) {
    isEditProfile = !isEditProfile;
  }

  @action
  void goToPreferences(bool isPreferences) {
    isPreferences = !isPreferences;
  }

  @action
  void goToFaqs(bool isFaqs) {
    if (isFaqs) {
      isFaqs = !isFaqs;
    }
  }

  @action
  void goToTerms(bool isTerms) {
    if (isTerms) {
      isTerms = !isTerms;
    }
  }
}
