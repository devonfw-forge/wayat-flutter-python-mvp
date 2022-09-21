import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/lang/language.dart';
import 'package:wayat/services/profile/profile_service.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';
import 'package:wayat/lang/language_constants.dart';
part 'profile_state.g.dart';

// ignore: library_private_types_in_public_api
class ProfileState = _ProfileState with _$ProfileState;

abstract class _ProfileState with Store {
  final ProfileService _profileService;

  @observable
  ProfileCurrentPages currentPage = ProfileCurrentPages.profile;

  @observable
  bool isAccount = false;

  @observable
  Language? language;

  @observable
  Locale? locale;

  Future<Locale> initializeLocale() async {
    locale = await getLocaleConstants();
    language = getLanguage(locale!.languageCode);
    return locale!;
  }

  @visibleForTesting
  Language getLanguage(String lnguageCode) {
    if (lnguageCode.contains('es')) {
      return Language('Español', 'es');
    }
    if (lnguageCode.contains('fr')) {
      return Language('Français', 'fr');
    }
    if (lnguageCode.contains('de')) {
      return Language('Deutsch', 'de');
    }
    if (lnguageCode.contains('nl')) {
      return Language('Dutch', 'nl');
    }
    return Language('English', 'en');
  }

  _ProfileState({ProfileService? profileService})
      : _profileService = profileService ?? ProfileServiceImpl();

  @action
  void setCurrentPage(ProfileCurrentPages newPage) {
    currentPage = newPage;
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
  Future deleteCurrentUser() async {
    _profileService.deleteCurrentUser();
  }

  @visibleForTesting
  void setLocale(Locale newLocale) {
    locale = newLocale;
  }

  @visibleForTesting
  void setLanguage(Language newLanguage) {
    language = newLanguage;
  }

  @action
  Future changeLanguage(Language language) async {
    setLanguage(language);
    Locale locale = await setLocaleConstants(language.languageCode);
    setLocale(locale);
  }
}
