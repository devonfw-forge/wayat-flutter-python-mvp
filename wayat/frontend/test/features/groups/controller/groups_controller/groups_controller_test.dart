import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/services/groups/groups_service.dart';

import 'groups_controller_test.mocks.dart';

@GenerateMocks([GroupsService])
void main() async {
  GroupsService mockGroupsService = MockGroupsService();
  setUpAll(() {});
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
    groupsController.groups = initialList;
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

    groupsController.groups = initialList;

    expect(groupsController.groups, initialList);

    groupsController.setGroups(secondList);

    expect(groupsController.groups, secondList);
  });
}

Group _createGroup({String? id, String? name}) {
  return Group(id: id ?? "", members: [], name: name ?? "", imageUrl: "");
}