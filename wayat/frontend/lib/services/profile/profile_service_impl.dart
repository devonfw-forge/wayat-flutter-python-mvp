import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/services/api_contract/api_contract.dart';
import 'package:wayat/services/profile/profile_service.dart';
import 'package:wayat/services/request/rest_service.dart';
import 'package:mime/mime.dart';

class ProfileServiceImpl extends RESTService implements ProfileService {
  @override
  Future<bool> uploadProfileImage(XFile? selectedImage) async {
    //Uint8List bytes = await io.File(selectedImage!.path).readAsBytes();
    String filePath = selectedImage!.path;
    String? fileType = lookupMimeType(filePath);

    StreamedResponse res = await super.sendPostImageRequest(
        APIContract.userProfilePicture, filePath, fileType!);
    bool done = res.statusCode / 10 == 20;
    return done;
  }

  @override
  Future<bool> updateProfileName(String name) async {
    bool done =
        (await super.sendPostRequest(APIContract.userProfile, {"name": name}))
                    .statusCode /
                10 ==
            20;
    return done;
  }

  @override
  Future<bool> deleteCurrentUser() async {
    bool done = (await super.sendDelRequest(APIContract.userProfile));
    return done;
  }

  @override
  Future<dynamic> logOut() async {
    final SessionState userSession = GetIt.I.get<SessionState>();

    Future done = userSession.logOut();
    userSession.currentUser = null;
    userSession.finishLoggedIn = false;
    userSession.googleSignedIn = false;
    userSession.hasDoneOnboarding = false;
    return done;
  }
}
