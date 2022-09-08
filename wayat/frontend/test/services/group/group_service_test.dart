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
// ignore: depend_on_referenced_packages
import 'package:mime/mime.dart';

import 'group_service_test.mocks.dart';

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

  test("Create calls the correct endpoint with the correct data", () async {
    http.Response mockResponse = MockResponse();
    when(mockResponse.body).thenReturn("{\"id\":\"newId\"}");
    http.StreamedResponse mockResponseImage = MockStreamedResponse();
    when(mockResponseImage.stream)
        .thenReturn(http.ByteStream.fromBytes(utf8.encode("newId")));

    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));
    String filePath = emptyFile.path;
    String? fileType = lookupMimeType(filePath);

    Contact contact = Contact(
        available: true,
        id: "id",
        name: "name",
        email: "email",
        imageUrl: "url",
        phone: "phone");
    Group group =
        Group(id: "id", contacts: [contact], name: "name", imageUrl: "url");

    when(mockHttpProvider.sendPostRequest(APIContract.groups, {
      "name": group.name,
      "members": ["id"]
    })).thenAnswer((_) => Future.value(mockResponse));

    when(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groups}/newId", filePath, fileType!))
        .thenAnswer((_) => Future.value(mockResponseImage));

    GroupsService groupsService = GroupsServiceImpl();

    await groupsService.create(group, emptyFile);

    verify(mockHttpProvider.sendGetRequest(APIContract.groups)).called(1);
    verify(mockHttpProvider.sendPostImageRequest(
            "${APIContract.groups}/newId", filePath, fileType))
        .called(1);
  });
}
