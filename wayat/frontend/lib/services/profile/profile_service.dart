import 'package:image_picker/image_picker.dart';

abstract class ProfileService {
  Future<bool> uploadProfileImage(XFile? selectedImage);
  Future<bool> updateProfileName(String name);
  Future<bool> deleteCurrentUser();
}
