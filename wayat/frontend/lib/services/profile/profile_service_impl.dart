import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/services/profile/profile_service.dart';
import 'package:mime/mime.dart';
import 'package:wayat/services/request/rest_service.dart';

class ProfileServiceImpl extends RESTService implements ProfileService {
  @override
  Future<bool> uploadProfileImage(XFile? selectedImage) async {
    //Uint8List bytes = await io.File(selectedImage!.path).readAsBytes();
    String filePath = selectedImage!.path;
    String? fileType = lookupMimeType(filePath);

    StreamedResponse res = await super
        .sendPostImageRequest("users/profile/picture", filePath, fileType!);
    bool done = res.statusCode / 10 == 20;
    return done;
  }

  @override
  Future<bool> updateProfileName(String name) async {
    bool done = (await super.sendPostRequest("users/profile", {"name": name}))
                .statusCode /
            10 ==
        20;
    return done;
  }
}
