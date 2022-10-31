import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/groups/controllers/manage_group_controller/manage_group_controller.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/groups/groups_service.dart';
import 'manage_group_controller_test.mocks.dart';

@GenerateMocks(
    [ContactsPageController, FriendsController, GroupsService, HttpProvider])
void main() async {
  ContactsPageController mockContactsPageController =
      MockContactsPageController();
  FriendsController mockFriendsController = MockFriendsController();
  GroupsService mockGroupsService = MockGroupsService();
  setUpAll(() {
    // This is necessary because Group uses appLocalizations for the default group name
    GetIt.I.registerSingleton<HttpProvider>(MockHttpProvider());
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
    GetIt.I.registerSingleton(AppConfigState());
  });

  test("AllContacts getter returns the contacts from the FriendsController",
      () {
    List<Contact> firstList = _generateContacts(["TestA", "TestB"]);
    List<Contact> secondList = _generateContacts(["TestA", "TestB", "TestC"]);
    when(mockFriendsController.allContacts).thenReturn(firstList);

    ManageGroupController manageGroupController =
        ManageGroupController(groupsService: mockGroupsService);

    expect(
        manageGroupController.allContacts, mockFriendsController.allContacts);

    when(mockFriendsController.allContacts).thenReturn(secondList);
    expect(
        manageGroupController.allContacts, mockFriendsController.allContacts);
  });

  test("AddContact adds contact to selectedContacts", () {
    Contact contact = _contactFactory("TestA");
    ManageGroupController manageGroupController =
        ManageGroupController(groupsService: mockGroupsService);
    expect(manageGroupController.selectedContacts, []);
    manageGroupController.addContact(contact);
    expect(manageGroupController.selectedContacts, [contact]);
  });

  test("RemoveContact removes contact from selectedContacts", () {
    Contact contact = _contactFactory("TestA");
    ManageGroupController manageGroupController =
        ManageGroupController(groupsService: mockGroupsService);
    manageGroupController.selectedContacts = mobx.ObservableList.of([contact]);
    expect(manageGroupController.selectedContacts, [contact]);
    manageGroupController.removeContact(contact);
    expect(manageGroupController.selectedContacts, []);
  });

  test("SetSelectedFile works correctly", () async {
    XFile emptyFile = XFile.fromData(Uint8List.fromList([]));

    ManageGroupController manageGroupController =
        ManageGroupController(groupsService: mockGroupsService);

    expect(manageGroupController.selectedFile, null);
    await manageGroupController.setSelectedFile(emptyFile);
    expect(manageGroupController.selectedFile, emptyFile);
  });

  group('SaveGroup validation', () {
    test(
        'SaveGroup does not create or update the group if there are less than two contacts selected',
        () {
      Group emptyGroup = Group.empty();
      emptyGroup.name = "Name";
      when(mockGroupsService.create(emptyGroup, null))
          .thenAnswer((_) => Future.value(null));
      ManageGroupController manageGroupController = ManageGroupController(
          group: emptyGroup, groupsService: mockGroupsService);

      manageGroupController.saveGroup();
      expect(manageGroupController.isValidGroup, false);
      verifyNever(mockGroupsService.create(emptyGroup, null));
      verifyNever(mockGroupsService.update(emptyGroup, null));
    });

    test(
        "SaveGroup creates the group if the ID is empty and there are more than two contacts selected",
        () {
      Group emptyGroup = Group.empty();
      emptyGroup.name = "Name";
      when(mockGroupsService.create(emptyGroup, null))
          .thenAnswer((_) => Future.value(null));
      ManageGroupController manageGroupController = ManageGroupController(
          group: emptyGroup, groupsService: mockGroupsService);
      Contact contactA = _contactFactory("TestA");
      manageGroupController.addContact(contactA);
      Contact contactB = _contactFactory("TestB");
      manageGroupController.addContact(contactB);

      manageGroupController.saveGroup();
      verify(mockGroupsService.create(emptyGroup, null)).called(1);
    });

    test(
        "SaveGroup updates the group if the ID is not empty and there are more than two contacts selected",
        () {
      Group group = Group.empty();
      group.name = "Name";
      group.id = "ID";
      when(mockGroupsService.update(group, null))
          .thenAnswer((_) => Future.value(null));
      ManageGroupController manageGroupController =
          ManageGroupController(group: group, groupsService: mockGroupsService);
      Contact contactA = _contactFactory("TestA");
      manageGroupController.addContact(contactA);
      Contact contactB = _contactFactory("TestB");
      manageGroupController.addContact(contactB);

      manageGroupController.saveGroup();
      verify(mockGroupsService.update(group, null)).called(1);
    });
  });

  test("ManageGroupController intialized with real service", () {
    ManageGroupController();
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    shareLocationTo: true,
    id: "id $contactName",
    name: contactName,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
  );
}

List<Contact> _generateContacts(List<String> names) {
  return names.map((name) => _contactFactory(name)).toList();
}
