import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/groups/controllers/manage_group_controller/manage_group_controller.dart';

import 'manage_group_controller_test.mocks.dart';

@GenerateMocks([ContactsPageController, FriendsController])
void main() async {
  ContactsPageController mockContactsPageController =
      MockContactsPageController();
  FriendsController mockFriendsController = MockFriendsController();
  setUpAll(() {
    // This is necessary because Group uses appLocalizations for the default group name
    GetIt.I
        .registerSingleton<ContactsPageController>(mockContactsPageController);
    when(mockContactsPageController.friendsController)
        .thenReturn(mockFriendsController);
  });

  test("AllContacts getter returns the contacts from the FriendsController",
      () {
    List<Contact> firstList = _generateContacts(["TestA", "TestB"]);
    List<Contact> secondList = _generateContacts(["TestA", "TestB", "TestC"]);
    when(mockFriendsController.allContacts).thenReturn(firstList);

    ManageGroupController manageGroupController = ManageGroupController();

    expect(
        manageGroupController.allContacts, mockFriendsController.allContacts);

    when(mockFriendsController.allContacts).thenReturn(secondList);
    expect(
        manageGroupController.allContacts, mockFriendsController.allContacts);
  });

  test("AddContact adds contact to selectedContacts", () {
    Contact contact = _contactFactory("TestA");
    ManageGroupController manageGroupController = ManageGroupController();
    expect(manageGroupController.selectedContacts, []);
    manageGroupController.addContact(contact);
    expect(manageGroupController.selectedContacts, [contact]);
  });

  test("RemoveContact removes contact from selectedContacts", () {
    Contact contact = _contactFactory("TestA");
    ManageGroupController manageGroupController = ManageGroupController();
    manageGroupController.selectedContacts = [contact];
    expect(manageGroupController.selectedContacts, [contact]);
    manageGroupController.removeContact(contact);
    expect(manageGroupController.selectedContacts, []);
  });
}

Contact _contactFactory(String contactName) {
  return Contact(
    available: true,
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
