import 'package:image_picker/image_picker.dart';
import 'package:wayat/domain/group/group.dart';

abstract class GroupsService {
  Future<List<Group>> getAll();
  Future create(Group group, XFile? picture);
  Future update(Group group, XFile? picture);
  Future delete(String groupId);
}
