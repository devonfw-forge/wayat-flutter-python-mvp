import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/services/request/rest_service.dart';
import "dart:io" as io;

class ProfileService extends RESTService {
  Future<bool> uploadProfileImage(XFile? selectedImage) async {
    Uint8List bytes = await io.File(selectedImage!.path).readAsBytes();
    Response res =
        await super.sendPostMediaRequest("users/profile/picture", bytes);
    print('-------------------------------Current image ${res.body}');
    bool done = res.statusCode / 10 == 20;
    return done;
  }

  Future<bool> updateProfileName(String name) async {
    bool done = (await super.sendPostRequest("users/profile", {"name": name}))
                .statusCode /
            10 ==
        20;
    return done;
  }
}
