import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/groups/groups_service.dart';
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';

class GroupsServiceImpl implements GroupsService {
  HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  // TODO: Visualize Groups
  @override
  Future<List<Group>> getAll() async {
    return [];
  }

  @override
  Future create(Group group, XFile? picture) async {
    Response response = await httpProvider.sendPostRequest(APIContract.groups, {
      "name": group.name,
      "members": group.contacts.map((e) => e.id).toList()
    });

    if (response.statusCode != 200 || picture == null) {
      return;
    }

    String groupId = json.decode(response.body)["id"];
    String type = lookupMimeType(picture.path) ?? picture.mimeType ?? "";

    await httpProvider.sendPostImageRequest(
        "${APIContract.groupPicture}/$groupId", picture.path, type);
  }
}
