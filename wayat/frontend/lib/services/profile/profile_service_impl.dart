import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/services/request/rest_service.dart';
import 'package:mime/mime.dart';

class ProfileService extends RESTService {
  Future<bool> uploadProfileImage(XFile? selectedImage) async {
    //Uint8List bytes = await io.File(selectedImage!.path).readAsBytes();
    String filePath = selectedImage!.path;
    String? fileType = lookupMimeType(filePath);

    StreamedResponse res = await super
        .sendPostImageRequest("users/profile/picture", filePath, fileType!);
    bool done = res.statusCode / 10 == 20;
    return done;
  }

  Future<bool> updateProfileName(String name) async {
    bool done = (await super.sendPostRequest("users/profile", {"name": name}))
                .statusCode /
            10 ==
        20;
    GetIt.I.get<SessionState>().currentUser!.name = name;
    return done;
  }
}
