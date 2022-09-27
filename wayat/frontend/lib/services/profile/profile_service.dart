import 'package:image_picker/image_picker.dart';

abstract class ProfileService {
  Future<bool> uploadProfileImage(XFile? selectedImage);
  Future<bool> updateProfileName(String name);

  /// *Delete* current user process
  Future<bool> deleteCurrentUser();
}
