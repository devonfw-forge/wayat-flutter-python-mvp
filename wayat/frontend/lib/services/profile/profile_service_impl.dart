import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/profile/profile_service.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';

class ProfileServiceImpl implements ProfileService {
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  PlatformService platformService = GetIt.I.get<PlatformService>();

  ProfileServiceImpl();

  ///Update profile image from camera or gallery [selectedImage]
  ///
  ///send [POST] response to backend to update user profile image
  @override
  Future<bool> uploadProfileImage(XFile? selectedImage) async {
    Uint8List fileBytes = await selectedImage!.readAsBytes();
    String fileType = (!platformService.isWeb)
        ? lookupMimeType(selectedImage.path) ?? selectedImage.mimeType ?? ""
        : selectedImage.mimeType ?? "";

    StreamedResponse res = await httpProvider.sendPostImageRequest(
        APIContract.userProfilePicture, fileBytes, fileType);
    bool done = res.statusCode / 10 == 20;
    return done;
  }

  ///Update profile name from [name]
  ///
  ///send [POST] response to backend to update user profile name
  @override
  Future<bool> updateProfileName(String name) async {
    bool done = (await httpProvider
                    .sendPostRequest(APIContract.userProfile, {"name": name}))
                .statusCode /
            10 ==
        20;
    return done;
  }

  ///Delete current user
  ///
  ///send [DELETE] response to backend to delete current user
  @override
  Future<bool> deleteCurrentUser() async {
    bool done = (await httpProvider.sendDelRequest(APIContract.userProfile));
    return done;
  }
}
