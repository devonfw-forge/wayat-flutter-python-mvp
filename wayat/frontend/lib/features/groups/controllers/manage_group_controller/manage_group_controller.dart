import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';

part 'manage_group_controller.g.dart';

// ignore: library_private_types_in_public_api
class ManageGroupController = _ManageGroupController
    with _$ManageGroupController;

abstract class _ManageGroupController with Store {
  _ManageGroupController({Group? group}) : group = group ?? Group.empty();

  @observable
  Group group;

  @observable
  List<Contact> selectedContacts = [];

  @observable
  late XFile selectedFile;

  TextEditingController groupNameController = TextEditingController();

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
}
