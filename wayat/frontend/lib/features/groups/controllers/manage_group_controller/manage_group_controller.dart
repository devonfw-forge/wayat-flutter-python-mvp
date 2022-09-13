import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/groups/groups_service.dart';
import 'package:wayat/services/groups/groups_service_impl.dart';

part 'manage_group_controller.g.dart';

// ignore: library_private_types_in_public_api
class ManageGroupController = _ManageGroupController
    with _$ManageGroupController;

abstract class _ManageGroupController with Store {
  _ManageGroupController({GroupsService? groupsService, Group? group})
      : group = group ?? Group.empty(),
        groupsService = groupsService ?? GroupsServiceImpl();

  @observable
  Group group;

  @observable
  late ObservableList<Contact> selectedContacts =
      ObservableList.of(group.members);

  @observable
  XFile? selectedFile;

  late TextEditingController groupNameController =
      TextEditingController(text: group.name);

  final GroupsService groupsService;

  final FriendsController _friendsController =
      GetIt.I.get<ContactsPageController>().friendsController;

  List<Contact> get allContacts => _friendsController.allContacts;

  @action
  void addContact(Contact contact) {
    selectedContacts.add(contact);
  }

  @action
  void removeContact(Contact contact) {
    selectedContacts.remove(contact);
  }

  @action
  void setSelectedFile(XFile? file) {
    selectedFile = file;
  }

  Future saveGroup() async {
    group.members = selectedContacts;
    group.name = (groupNameController.text != "")
        ? groupNameController.text
        //AppLocalizations cannot be used from unit tests because they require a context to initialize
        : appLocalizations.newGroup;

    if (group.id == "") {
      await groupsService.create(group, selectedFile);
    } else {
      // TODO: Edit group
    }
  }

  // Hurts coverage because it cannot be tested (cannot get context to mock,
  //verify calls or call from unit tests)
  Future getFromSource(ImageSource source, BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    setSelectedFile(newImage);
    Navigator.pop(context);
  }
}