import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/profile/profile_service.dart';
import 'package:wayat/services/profile/profile_service_impl.dart';

import 'profile_service_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpProvider>(),
  MockSpec<Response>(),
  MockSpec<StreamedResponse>(),
  MockSpec<PlatformService>()
])
void main() async {
  HttpProvider mockHttpProvider = MockHttpProvider();
  MockPlatformService mockPlatformService = MockPlatformService();

  setUpAll(() {
    GetIt.I.registerSingleton(mockHttpProvider);
    GetIt.I.registerSingleton<PlatformService>(mockPlatformService);
  });

  test("uploadProfileImage calls the correct endpoint", () async {
    XFile emptyFile =
        XFile.fromData(Uint8List.fromList([]), path: "path", name: "name");
    StreamedResponse mockStreamedResponse = MockStreamedResponse();
    when(mockStreamedResponse.statusCode).thenReturn(200);
    when(mockHttpProvider.sendPostImageRequest(
            APIContract.userProfilePicture, Uint8List.fromList([]), ""))
        .thenAnswer((_) async => mockStreamedResponse);

    ProfileService profileService = ProfileServiceImpl();

    bool res = await profileService.uploadProfileImage(emptyFile);

    expect(res, true);
    verify(mockHttpProvider.sendPostImageRequest(
            APIContract.userProfilePicture, Uint8List.fromList([]), ""))
        .called(1);
  });

  test("updateProfileName calls the correct endpoint", () async {
    Response mockHttpResponse = MockResponse();
    when(mockHttpResponse.statusCode).thenReturn(200);
    String name = "name";
    when(mockHttpProvider
            .sendPostRequest(APIContract.userProfile, {"name": name}))
        .thenAnswer((_) async => mockHttpResponse);

    ProfileService profileService = ProfileServiceImpl();

    bool res = await profileService.updateProfileName(name);

    expect(res, true);
    verify(mockHttpProvider
        .sendPostRequest(APIContract.userProfile, {"name": name})).called(1);
  });

  test("deleteCurrentUser calls the correct endpoint", () async {
    when(mockHttpProvider.sendDelRequest(APIContract.userProfile))
        .thenAnswer((_) async => true);

    ProfileService profileService = ProfileServiceImpl();

    bool res = await profileService.deleteCurrentUser();

    expect(res, true);
    verify(mockHttpProvider.sendDelRequest(APIContract.userProfile)).called(1);
  });
}
