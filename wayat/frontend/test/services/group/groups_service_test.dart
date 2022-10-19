import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/groups/groups_service.dart';
import 'package:wayat/services/groups/groups_service_impl.dart';
import 'package:http/http.dart' as http;

import 'groups_service_test.mocks.dart';

@GenerateMocks([HttpProvider, http.Response, http.StreamedResponse])
void main() async {
  HttpProvider mockHttpProvider = MockHttpProvider();

  setUpAll(() {
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
  });

  test("GetAll calls the correct endpoint with the correct data", () async {
    when(mockHttpProvider.sendGetRequest(APIContract.groups))
        .thenAnswer((_) => Future.value({}));

    GroupsService groupsService = GroupsServiceImpl();

    await groupsService.getAll();

    verify(mockHttpProvider.sendGetRequest(APIContract.groups)).called(1);
  });

  test("GetAll converts from List of IDs to List of Contacts", () async {
    Contact contact = Contact(
        shareLocationTo: true,
        id: "id",
        name: "name",
        email: "email",
        imageUrl: "url",
        phone: "phone");
    Group group =
        Group(id: "id", members: [contact], name: "name", imageUrl: "url");

    Map<String, dynamic> groupResponse = group.toMap();
    groupResponse["members"] = [contact.id];

    when(mockHttpProvider.sendGetRequest(APIContract.contacts))
        .thenAnswer((_) => Future.value({
              "users": [contact.toMap()]
            }));

    when(mockHttpProvider.sendGetRequest(APIContract.groups))
        .thenAnswer((_) => Future.value({
              "groups": [groupResponse]
            }));

    GroupsService groupsService = GroupsServiceImpl();

    List<Group> groups = await groupsService.getAll();

    verify(mockHttpProvider.sendGetRequest(APIContract.groups)).called(1);
    verify(mockHttpProvider.sendGetRequest(APIContract.contacts)).called(1);

    expect(groups, [group]);
  });

  test("Create calls the correct endpoint with the correct data", () async {
    http.Response mockResponse = MockResponse();
    when(mockResponse.body).thenReturn("{\"id\":\"newId\"}");
    when(mockResponse.statusCode).thenReturn(200);
    http.StreamedResponse mockResponseImage = MockStreamedResponse();
    when(mockResponseImage.stream)
        .thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode("newId")));

    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));
    Future<Uint8List> fileBytes = emptyFile.readAsBytes();
    String fileType = "";

    Contact contact = Contact(
        shareLocationTo: true,
        id: "id",
        name: "name",
        email: "email",
        imageUrl: "url",
        phone: "phone");
    Group group =
        Group(id: "id", members: [contact], name: "name", imageUrl: "url");

    when(mockHttpProvider.sendPostRequest(APIContract.groups, {
      "name": group.name,
      "members": ["id"]
    })).thenAnswer((_) => Future.value(mockResponse));

    when(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groupPicture}/newId", await fileBytes, fileType))
        .thenAnswer((_) => Future.value(mockResponseImage));

    GroupsService groupsService = GroupsServiceImpl();

    await groupsService.create(group, emptyFile);

    verify(mockHttpProvider.sendPostRequest(APIContract.groups, {
      "name": group.name,
      "members": ["id"]
    })).called(1);
    verify(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groupPicture}/newId", await fileBytes, fileType))
        .called(1);
  });

  test("If there is an error in create, we dont call POST image", () async {
    http.Response mockResponse = MockResponse();
    when(mockResponse.body).thenReturn("{\"id\":\"newId\"}");
    when(mockResponse.statusCode).thenReturn(425);
    http.StreamedResponse mockResponseImage = MockStreamedResponse();
    when(mockResponseImage.stream)
        .thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode("newId")));

    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));
    Future<Uint8List> fileBytes = emptyFile.readAsBytes();
    String fileType = "";

    Contact contact = Contact(
        shareLocationTo: true,
        id: "id",
        name: "name",
        email: "email",
        imageUrl: "url",
        phone: "phone");
    Group group =
        Group(id: "id", members: [contact], name: "name", imageUrl: "url");

    when(mockHttpProvider.sendPostRequest(APIContract.groups, {
      "name": group.name,
      "members": ["id"]
    })).thenAnswer((_) => Future.value(mockResponse));

    when(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groupPicture}/newId", await fileBytes, fileType))
        .thenAnswer((_) => Future.value(mockResponseImage));

    GroupsService groupsService = GroupsServiceImpl();

    await groupsService.create(group, emptyFile);

    verify(mockHttpProvider.sendPostRequest(APIContract.groups, {
      "name": group.name,
      "members": ["id"]
    })).called(1);
    verifyNever(mockHttpProvider.sendPostImageRequest(
        "${APIContract.groupPicture}/newId", await fileBytes, fileType));
  });

  test("Update calls the correct endpoint with the correct data", () async {
    http.StreamedResponse mockResponseImage = MockStreamedResponse();
    when(mockResponseImage.stream)
        .thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode("id")));

    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));
    Uint8List fileBytes = await emptyFile.readAsBytes();
    String fileType = "";

    Contact contact = Contact(
        shareLocationTo: true,
        id: "id",
        name: "name",
        email: "email",
        imageUrl: "url",
        phone: "phone");
    Group group =
        Group(id: "id", members: [contact], name: "name", imageUrl: "url");

    when(mockHttpProvider.sendPutRequest("${APIContract.groups}/${group.id}", {
      "name": group.name,
      "members": [contact.id]
    })).thenAnswer((_) => Future.value(true));

    when(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groupPicture}/id", fileBytes, fileType))
        .thenAnswer((_) => Future.value(mockResponseImage));

    GroupsService groupsService = GroupsServiceImpl();

    await groupsService.update(group, emptyFile);

    verify(
        mockHttpProvider.sendPutRequest("${APIContract.groups}/${group.id}", {
      "name": group.name,
      "members": [contact.id]
    })).called(1);
    verify(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groupPicture}/id", fileBytes, fileType))
        .called(1);
  });

  test("If there is no picture, we dont post any on update", () async {
    http.StreamedResponse mockResponseImage = MockStreamedResponse();
    when(mockResponseImage.stream)
        .thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode("id")));

    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));
    Uint8List fileBytes = await emptyFile.readAsBytes();
    String fileType = "";

    Contact contact = Contact(
        shareLocationTo: true,
        id: "id",
        name: "name",
        email: "email",
        imageUrl: "url",
        phone: "phone");
    Group group =
        Group(id: "id", members: [contact], name: "name", imageUrl: "url");

    when(mockHttpProvider.sendPutRequest("${APIContract.groups}/${group.id}", {
      "name": group.name,
      "members": [contact.id]
    })).thenAnswer((_) => Future.value(true));

    when(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groupPicture}/id", fileBytes, fileType))
        .thenAnswer((_) => Future.value(mockResponseImage));

    GroupsService groupsService = GroupsServiceImpl();

    await groupsService.update(group, null);

    verify(
        mockHttpProvider.sendPutRequest("${APIContract.groups}/${group.id}", {
      "name": group.name,
      "members": [contact.id]
    })).called(1);
    verifyNever(mockHttpProvider.sendPostImageRequest(
        "${APIContract.groupPicture}/id", fileBytes, fileType));
  });

  test("If the group udpate fails, we don't send the picture", () async {
    http.StreamedResponse mockResponseImage = MockStreamedResponse();
    when(mockResponseImage.stream)
        .thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode("id")));

    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));
    Uint8List fileBytes = await emptyFile.readAsBytes();
    String fileType = "";

    Contact contact = Contact(
        shareLocationTo: true,
        id: "id",
        name: "name",
        email: "email",
        imageUrl: "url",
        phone: "phone");
    Group group =
        Group(id: "id", members: [contact], name: "name", imageUrl: "url");

    when(mockHttpProvider.sendPutRequest("${APIContract.groups}/${group.id}", {
      "name": group.name,
      "members": [contact.id]
    })).thenAnswer((_) => Future.value(false));

    when(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groupPicture}/id", fileBytes, fileType))
        .thenAnswer((_) => Future.value(mockResponseImage));

    GroupsService groupsService = GroupsServiceImpl();

    await groupsService.update(group, emptyFile);

    verify(
        mockHttpProvider.sendPutRequest("${APIContract.groups}/${group.id}", {
      "name": group.name,
      "members": [contact.id]
    })).called(1);
    verifyNever(mockHttpProvider.sendPostImageRequest(
        "${APIContract.groupPicture}/id", fileBytes, fileType));
  });

  test("Delete calls the correct endpoint", () async {
    String groupId = "id";
    when(mockHttpProvider.sendDelRequest("${APIContract.groups}/$groupId"))
        .thenAnswer((_) => Future.value(true));

    GroupsService groupsService = GroupsServiceImpl();

    await groupsService.delete(groupId);

    verify(mockHttpProvider.sendDelRequest("${APIContract.groups}/$groupId"))
        .called(1);
  });
}
