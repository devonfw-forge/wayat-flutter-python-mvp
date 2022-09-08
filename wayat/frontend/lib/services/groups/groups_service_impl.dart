import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/groups/groups_service.dart';

class GroupsServiceImpl implements GroupsService {
  HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  @override
  Future<List<Group>> getAll() async {
    return [];
  }

  @override
  Future create(Group group, XFile picture) async {}

  Future _sendPicture(XFile picture) async {}
}
