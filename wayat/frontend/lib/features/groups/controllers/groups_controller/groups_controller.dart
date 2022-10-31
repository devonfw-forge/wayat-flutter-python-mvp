// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/services/groups/groups_service.dart';
import 'package:wayat/services/groups/groups_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

part 'groups_controller.g.dart';

/// Manages the state of the groups feature, such as navigation and information fetching
// ignore: library_private_types_in_public_api
class GroupsController = _GroupsController with _$GroupsController;

abstract class _GroupsController with Store {
  /// Manages the communication with the server related to [Group].
  GroupsService groupsService;

  /// Main constructor. Receives a [GroupService] optional parameter
  /// for testing purposes.
  _GroupsController({GroupsService? groupsService})
      : groupsService = groupsService ?? GroupsServiceImpl();

  /// The list of all of the created [Group] entities.
  @observable
  ObservableList<Group> groups = ObservableList.of([]);

  /// If it is null, we will be in the [GroupsPage]. Otherwise, we will be
  /// either in the [ViewGroupPage] or in the [ManageGroupPage].
  @observable
  Group? selectedGroup;

  /// Calls [GroupService.getAll] to update the user's groups. They are only
  /// updated in the UI if the response differs with the local data.
  ///
  /// Returns 'true' if the groups were updated and 'false' if there was no need
  Future<bool> updateGroups() async {
    List<Group> fetchedGroups = await groupsService.getAll();
    if (ListUtilsService.haveDifferentElements(
        fetchedGroups, groups.toList())) {
      setGroups(fetchedGroups);
      return true;
    }
    return false;
  }

  Future<void> groupsGuard(String groupId) async {
    if (selectedGroup != null && selectedGroup?.id == groupId) {
      return;
    }
    await updateGroups();
    selectedGroup = groups.firstWhereOrNull((element) => element.id == groupId);
  }

  @action
  void setGroups(List<Group> groups) {
    this.groups = ObservableList.of(groups);
  }

  Future<void> createGroup(Group group, XFile picture) async {
    await groupsService.create(group, picture);
  }

  void setSelectedGroup(Group? group) {
    selectedGroup = group;
  }

  Future<void> deleteGroup(Group group) async {
    groups.remove(group);
    await groupsService.delete(group.id);
  }
}
