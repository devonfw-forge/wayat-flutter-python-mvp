import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/lang/language.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/profile/profile_service.dart';

import 'profile_state_test.mocks.dart';

@GenerateMocks([ProfileService, SessionState, HttpProvider])
void main() async {
  ProfileService mockProfileService = MockProfileService();
  SessionState mockSessionState = MockSessionState();
  setUpAll(() {
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
  });
  test("Initial State is correct", () {
    ProfileState profileState =
        ProfileState(profileService: mockProfileService);
    expect(profileState.currentPage, ProfileCurrentPages.profile);
    expect(profileState.isAccount, false);
  });

  test("SetCurrentPage is correct", () {
    ProfileState profileState =
        ProfileState(profileService: mockProfileService);
    expect(profileState.currentPage, ProfileCurrentPages.profile);
    profileState.setCurrentPage(ProfileCurrentPages.editProfile);
    expect(profileState.currentPage, ProfileCurrentPages.editProfile);
  });

  test("UpdateCurrentUser calls update in session state", () async {
    when(mockSessionState.updateCurrentUser())
        .thenAnswer((_) => Future.value(null));

    ProfileState profileState =
        ProfileState(profileService: mockProfileService);

    await profileState.updateCurrentUser();

    verify(mockSessionState.updateCurrentUser()).called(1);
  });

  test("UpdateUserImage updates the image and, after, the user", () async {
    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));

    when(mockSessionState.updateCurrentUser())
        .thenAnswer((_) => Future.value(null));

    ProfileState profileState =
        ProfileState(profileService: mockProfileService);
    when(mockProfileService.uploadProfileImage(emptyFile))
        .thenAnswer((_) => Future.value(true));

    await profileState.updateUserImage(emptyFile);

    verify(mockSessionState.updateCurrentUser()).called(1);
    verify(mockProfileService.uploadProfileImage(emptyFile)).called(1);
  });

  test(
      "UpdateCurrentUserName updates the current user's name and notifies the server",
      () async {
    String newName = "New name";
    String oldName = "Old name";
    MyUser testUser = _generateMyUser(oldName);

    when(mockSessionState.currentUser).thenReturn(testUser);

    ProfileState profileState =
        ProfileState(profileService: mockProfileService);
    when(mockProfileService.updateProfileName(newName))
        .thenAnswer((_) => Future.value(true));

    expect(mockSessionState.currentUser!.name, oldName);

    await profileState.updateCurrentUserName(newName);

    expect(mockSessionState.currentUser!.name, newName);
    verify(mockProfileService.updateProfileName(newName)).called(1);
  });

  test("Can generate ProfileState without passing ProfileService", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    // ignore: unused_local_variable
    ProfileState profileState = ProfileState();
    expect(1, 1);
  });

  test("getLanguage method", () async {
    ProfileState profileState =
        ProfileState(profileService: mockProfileService);

    expect(profileState.getLanguage("es"), Language("Español", "es"));
    expect(profileState.getLanguage("fr"), Language("Français", "fr"));
    expect(profileState.getLanguage("de"), Language("Deutsch", "de"));
    expect(profileState.getLanguage("nl"), Language("Dutch", "nl"));
    expect(profileState.getLanguage("en"), Language("English", "en"));
  });

  test("Delete curren user method", () async {
    ProfileState profileState =
        ProfileState(profileService: mockProfileService);

    when(mockProfileService.deleteCurrentUser())
        .thenAnswer((_) => Future.value(true));

    await profileState.deleteCurrentUser();
    verify(mockProfileService.deleteCurrentUser()).called(1);
  });

  test("set Locale and language", () async {
    ProfileState profileState =
        ProfileState(profileService: mockProfileService);

    Locale testLocale = const Locale("en", "US");
    profileState.setLocale(testLocale);
    expect(profileState.locale, testLocale);
    Locale newTestLocale = const Locale("es", "ES");
    profileState.setLocale(newTestLocale);
    expect(profileState.locale != testLocale, true);
    expect(profileState.locale, newTestLocale);

    Language testLanguage = Language("en", "US");
    profileState.setLanguage(testLanguage);
    expect(profileState.language, testLanguage);
    Language newTestLanguage = Language("es", "ES");
    profileState.setLanguage(newTestLanguage);
    expect(profileState.language != testLanguage, true);
    expect(profileState.language, newTestLanguage);
  });

  test("set Locale and language", () async {
    ProfileState profileState =
        ProfileState(profileService: mockProfileService);

    Locale testLocale = const Locale("en", "US");
    profileState.setLocale(testLocale);
    expect(profileState.locale, testLocale);
    Locale newTestLocale = const Locale("es", "ES");
    profileState.setLocale(newTestLocale);
    expect(profileState.locale != testLocale, true);
    expect(profileState.locale, newTestLocale);

    Language testLanguage = Language("en", "US");
    profileState.setLanguage(testLanguage);
    expect(profileState.language, testLanguage);
    Language newTestLanguage = Language("es", "ES");
    profileState.setLanguage(newTestLanguage);
    expect(profileState.language != testLanguage, true);
    expect(profileState.language, newTestLanguage);
  });

  test("change language", () async {
    ProfileState profileState =
        ProfileState(profileService: mockProfileService);

    Locale testLocale = const Locale("en", "US");
    profileState.setLocale(testLocale);
    Language testLanguage = Language("en", "US");
    profileState.setLanguage(testLanguage);

    await profileState.changeLanguage(Language("Español", "es"));
    expect(profileState.locale, const Locale("es", "ES"));
    expect(profileState.language, Language("Español", "es"));
  });
}

MyUser _generateMyUser(String name) {
  return MyUser(
      id: "id",
      name: name,
      email: "name@mail.com",
      imageUrl: "https://example.com",
      phone: "123",
      onboardingCompleted: true,
      shareLocationEnabled: true);
}
