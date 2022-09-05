import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/services/profile/profile_service.dart';

import 'profile_state_test.mocks.dart';

@GenerateMocks([ProfileService, SessionState])
void main() async {
  ProfileService mockProfileService = MockProfileService();
  SessionState mockSessionState = MockSessionState();
  setUpAll(() {
    GetIt.I.registerSingleton<SessionState>(mockSessionState);
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
