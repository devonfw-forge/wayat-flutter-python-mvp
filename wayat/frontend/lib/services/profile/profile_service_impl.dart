import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/profile/profile_service.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';

class ProfileServiceImpl implements ProfileService {
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  @override
  Future<bool> uploadProfileImage(XFile? selectedImage) async {
    //Uint8List bytes = await io.File(selectedImage!.path).readAsBytes();
    String filePath = selectedImage!.path;
    String fileType = lookupMimeType(filePath) ?? "";

    StreamedResponse res = await httpProvider.sendPostImageRequest(
        APIContract.userProfilePicture, filePath, fileType);
    bool done = res.statusCode / 10 == 20;
    return done;
  }

  @override
  Future<bool> updateProfileName(String name) async {
    bool done = (await httpProvider
                    .sendPostRequest(APIContract.userProfile, {"name": name}))
                .statusCode /
            10 ==
        20;
    return done;
  }

  @override
  Future<bool> deleteCurrentUser() async {
    bool done = (await httpProvider.sendDelRequest(APIContract.userProfile));
    return done;
  }
}
