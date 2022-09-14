import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/groups/groups_service.dart';
import 'package:mobx/mobx.dart' as mobx;

import 'groups_controller_test.mocks.dart';

@GenerateMocks([GroupsService, HttpProvider])
void main() async {
  GroupsService mockGroupsService = MockGroupsService();
  setUpAll(() {
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
  });
  test("UpdateGroups gets groups from the service", () async {
    when(mockGroupsService.getAll()).thenAnswer((_) => Future.value([]));
    GroupsController groupsController =
        GroupsController(groupsService: mockGroupsService);

    await groupsController.updateGroups();

    verify(mockGroupsService.getAll()).called(1);
  });

  test("FetchGroups changes the group list only if they are different",
      () async {
    List<Group> initialList = [_createGroup(id: "id", name: "name")];
    List<Group> secondList = [
      _createGroup(id: "id", name: "name"),
      _createGroup(id: "id2", name: "name2")
    ];

    GroupsController groupsController =
        GroupsController(groupsService: mockGroupsService);
    groupsController.groups = mobx.ObservableList.of(initialList);
    when(mockGroupsService.getAll())
        .thenAnswer((_) => Future.value(initialList));

    expect(groupsController.groups, initialList);

    bool listChanged = await groupsController.updateGroups();

    expect(groupsController.groups, initialList);
    expect(listChanged, false);

    when(mockGroupsService.getAll())
        .thenAnswer((_) => Future.value(secondList));

    listChanged = await groupsController.updateGroups();

    expect(groupsController.groups, secondList);
    expect(listChanged, true);
  });

  test("setGroups works correctly", () async {
    List<Group> initialList = [_createGroup(id: "id", name: "name")];
    List<Group> secondList = [
      _createGroup(id: "id", name: "name"),
      _createGroup(id: "id2", name: "name2")
    ];

    GroupsController groupsController =
        GroupsController(groupsService: mockGroupsService);

    groupsController.groups = mobx.ObservableList.of(initialList);

    expect(groupsController.groups, initialList);

    groupsController.setGroups(secondList);

    expect(groupsController.groups, secondList);
  });

  test("CreateGroup calls the correct method in the service", () {
    Group group = Group.empty();
    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));

    when(mockGroupsService.create(group, emptyFile))
        .thenAnswer((_) => Future.value(null));

    GroupsController groupsController =
        GroupsController(groupsService: mockGroupsService);

    groupsController.createGroup(group, emptyFile);

    verify(mockGroupsService.create(group, emptyFile)).called(1);
  });

  test("SetSelectedGroup is correct", () {
    Group group = Group.empty();

    GroupsController groupsController =
        GroupsController(groupsService: mockGroupsService);

    expect(groupsController.selectedGroup, null);

    groupsController.setSelectedGroup(group);

    expect(groupsController.selectedGroup, group);
  });

  test("SetEditGroup is correct", () {
    GroupsController groupsController =
        GroupsController(groupsService: mockGroupsService);

    expect(groupsController.editGroup, false);

    groupsController.setEditGroup(true);

    expect(groupsController.editGroup, true);

    groupsController.setEditGroup(false);

    expect(groupsController.editGroup, false);
  });

  test("SetUpdatingGroup is correct", () {
    GroupsController groupsController =
        GroupsController(groupsService: mockGroupsService);

    expect(groupsController.updatingGroup, false);

    groupsController.setUpdatingGroup(true);

    expect(groupsController.updatingGroup, true);

    groupsController.setUpdatingGroup(false);

    expect(groupsController.updatingGroup, false);
  });

  test("GroupsController intialized with real service", () {
    GroupsController();
  });
}

Group _createGroup({String? id, String? name}) {
  return Group(id: id ?? "", members: [], name: name ?? "", imageUrl: "");
}
