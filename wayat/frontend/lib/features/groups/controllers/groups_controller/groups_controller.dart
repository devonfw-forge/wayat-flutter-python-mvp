import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/services/groups/groups_service.dart';
import 'package:wayat/services/groups/groups_service_impl.dart';

part 'groups_controller.g.dart';

// ignore: library_private_types_in_public_api
class GroupsController = _GroupsController with _$GroupsController;

abstract class _GroupsController with Store {
  GroupsService groupsService;

  _GroupsController({GroupsService? groupsService})
      : groupsService = groupsService ?? GroupsServiceImpl();

  @observable
  ObservableList<Group> groups = ObservableList.of([]);

  /// Calls [GroupService.getAll] to update the user's groups. They are only
  /// updated in the UI if the response differs with the local data.
  ///
  /// Returns 'true' if the groups were updated and 'false' if there was no need
  Future<bool> updateGroups() async {
    List<Group> fetchedGroups = await groupsService.getAll();
    if (fetchedGroups != groups) {
      setGroups(fetchedGroups);
      return true;
    }
    return false;
  }

  @action
  void setGroups(List<Group> groups) {
    this.groups = ObservableList.of(groups);
  }

  Future createGroup(Group group, XFile picture) async {
    await groupsService.create(group, picture);
  }
}
