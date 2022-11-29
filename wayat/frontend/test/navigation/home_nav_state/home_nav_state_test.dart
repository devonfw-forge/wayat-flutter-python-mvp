import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'home_nav_state_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ContactsPageController>(),
  MockSpec<FriendsController>(),
])
void main() async {
  MockContactsPageController mockController = MockContactsPageController();
  MockFriendsController mockFriendsController = MockFriendsController();

  setUpAll(() {
    GetIt.I.registerSingleton<ContactsPageController>(mockController);
    when(mockController.friendsController).thenReturn(mockFriendsController);
    when(mockFriendsController.allContacts).thenReturn(_contactListFactory());
  });
  test("Initial Home State is correct", () {
    HomeNavState homeState = HomeNavState();
    expect(homeState.selectedContact, null);
  });
  test("Set selected contacts test", () {
    HomeNavState homeState = HomeNavState();
    Contact oldContact = _contactFactory("Old Contact");
    Contact newContact = _contactFactory("New contact");
    homeState.selectedContact = oldContact;

    expect(homeState.selectedContact, oldContact);

    homeState.setSelectedContact(newContact);

    expect(homeState.selectedContact, newContact);
  });

  test("Check Contact profile guard mantains the same object", () async {
    HomeNavState homeState = HomeNavState();
    Contact contact = _contactFactory("1");
    homeState.selectedContact = contact;
    await homeState.contactProfileGuard(contact.id);
    expect(homeState.selectedContact, contact);
  });

  test("Check Contact profile guard retrieve contact if not set", () async {
    HomeNavState homeState = HomeNavState();
    await homeState.contactProfileGuard("1");
    verify(mockFriendsController.updateContacts()).called(1);
    expect(homeState.selectedContact!.id, "1");
  });
}

Contact _contactFactory(String id) {
  return Contact(
    shareLocationTo: true,
    id: id,
    name: "username$id",
    email: "user$id@mail.com",
    imageUrl: "https://example.com/image$id",
    phone: "123$id",
  );
}

List<Contact> _contactListFactory() {
  return [
    _contactFactory("1"),
    _contactFactory("2"),
    _contactFactory("3"),
  ];
}
