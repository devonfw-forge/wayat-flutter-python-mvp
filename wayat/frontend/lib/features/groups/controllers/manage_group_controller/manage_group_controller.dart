import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

/// Controller to manage the changes when creating or updating an existing [Group].
// ignore: library_private_types_in_public_api
class ManageGroupController = _ManageGroupController
    with _$ManageGroupController;

abstract class _ManageGroupController with Store {
  /// Main constructor.
  ///
  /// It optionally receives a [GroupService] for testing purposes and a [Group].
  ///
  /// If the [Group] is not passed, it creates an empty one and assumes we are
  /// creating a new group. Otherwise, it assumes that we are editing said [Group].
  ///
  /// The contacts are updated when creating this controller because if the user
  /// enters directly in this URL, the contact list would be empty.
  _ManageGroupController({GroupsService? groupsService, Group? group})
      : group = group ?? Group.empty(),
        groupsService = groupsService ?? GroupsServiceImpl() {
    _friendsController.updateContacts();
  }

  /// The group to edit/create.
  @observable
  Group group;

  /// Whether the group has at least two participants
  @computed
  bool get isValidGroup => errorMessage != null ? errorMessage!.isEmpty : false;

  /// Message containing the error in the current Group
  @observable
  String? errorMessage;

  /// Returns all of the contacts that are currently selected to form part of the [Group].
  @observable
  late ObservableList<Contact> selectedContacts =
      ObservableList.of(group.members);

  /// The selected file in case the user wants to add or change the [Group]'s picture.
  @observable
  XFile? selectedFile;

  Uint8List? selectedFileBytes;

  /// Textfield to edit or add the [Group.name].
  ///
  /// It is initialized `late` because we want to add `group.name` as an initial
  /// value if possible.
  late TextEditingController groupNameController =
      TextEditingController(text: group.name);

  /// Manages the communication with the server.
  ///
  /// Here is mainly used to update or create the [Group].
  final GroupsService groupsService;

  /// Necessary to obtain all of the contacts to show in the add participants list.
  final FriendsController _friendsController =
      GetIt.I.get<ContactsPageController>().friendsController;

  /// Getter for all of the contacts
  List<Contact> get allContacts => _friendsController.allContacts;

  /// Adds a new contact and executes the validation.
  @action
  void addContact(Contact contact) {
    selectedContacts.add(contact);
    groupValidation();
  }

  /// Removes a contact and executes the validation.
  @action
  void removeContact(Contact contact) {
    selectedContacts.remove(contact);
    groupValidation();
  }

  @action
  Future<void> setSelectedFile(XFile? file) async {
    selectedFileBytes = await file!.readAsBytes();
    selectedFile = file;
  }

  /// Gets the name, picture and participants and creates the [Group].
  ///
  /// If the name is empty, it will load a default name using the language
  /// selected by the user in that moment.
  ///
  /// It will not save the [Group] if there is less than `2` participants selected.
  ///
  /// If the [Group]  is [Group.empty()], which means that the [Group.id] is empty,
  /// it will call the [groupService.create()], otherwise it will call [groupService.update()].
  Future<void> saveGroup() async {
    group.members = selectedContacts;
    group.name = (groupNameController.text != "")
        ? groupNameController.text
        //AppLocalizations cannot be used from unit tests because they require a context to initialize
        : appLocalizations.newGroup;

    if (isValidGroup) {
      if (group.id == "") {
        await groupsService.create(group, selectedFile);
      } else {
        await groupsService.update(group, selectedFile);
      }
    }
  }

  /// Validates that the [Group] has more than `2` participants.
  @action
  void groupValidation() {
    if (selectedContacts.length < 2) {
      errorMessage = appLocalizations.groupValidation;
    } else {
      errorMessage = "";
    }
  }

  /// Asigns the selected file from the user to [selectedFile].
  Future getFromSource(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? newImage = await imagePicker.pickImage(source: source);
    await setSelectedFile(newImage);
    //Navigator.of(context, rootNavigator: true).pop();
  }

  /// Asigns the selected file from the user to [selectedFile].
  Future getImageDesktop() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['jpg', 'png'],
    );
    final XFile? newImage =
    await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    await setSelectedFile(newImage);
  }
}
