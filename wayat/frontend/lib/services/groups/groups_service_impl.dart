import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/groups/group_response.dart';
import 'package:wayat/services/groups/groups_service.dart';
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';

/// Implementation of [GroupService]
class GroupsServiceImpl implements GroupsService {
  /// Makes the HTTP calls for the service.
  HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  @override
  Future<List<Group>> getAll() async {
    Map<String, dynamic> response =
        await httpProvider.sendGetRequest(APIContract.groups);

    if (!response.containsKey("groups")) {
      return [];
    }

    List<GroupResponse> groupsWithMemberIds =
        (response["groups"] as List<dynamic>)
            .map((e) => GroupResponse.fromMap(e))
            .toList();
    List<Contact> contacts = await ContactServiceImpl().getAll();
    List<Group> groups = groupsWithMemberIds
        .map((g) => Group(
            id: g.id,
            name: g.name,
            imageUrl: g.imageUrl,
            members: g.members
                .map((memberId) =>
                    contacts.firstWhere((member) => member.id == memberId))
                .toList()))
        .toList();
    return groups;
  }

  @override
  Future create(Group group, XFile? picture) async {
    Response response = await httpProvider.sendPostRequest(APIContract.groups, {
      "name": group.name,
      "members": group.members.map((e) => e.id).toList()
    });

    if (response.statusCode != 200 || picture == null) {
      return;
    }

    String groupId = json.decode(response.body)["id"];
    String type = lookupMimeType(picture.path) ?? picture.mimeType ?? "";

    await httpProvider.sendPostImageRequest(
        "${APIContract.groupPicture}/$groupId", picture.path, type);
  }

  @override
  Future update(Group group, XFile? picture) async {
    bool response = await httpProvider.sendPutRequest(
        "${APIContract.groups}/${group.id}", {
      "name": group.name,
      "members": group.members.map((e) => e.id).toList()
    });

    if (picture != null && response) {
      String type = lookupMimeType(picture.path) ?? picture.mimeType ?? "";

      await httpProvider.sendPostImageRequest(
          "${APIContract.groupPicture}/${group.id}", picture.path, type);
    }
  }

  @override
  Future delete(String groupId) async {
    await httpProvider.sendDelRequest("${APIContract.groups}/$groupId");
  }
}
