import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'friends_controller_test.mocks.dart';

@GenerateMocks([ContactService])
void main() async {
  ContactService mockContactService = MockContactService();
  FriendsController controller =
      FriendsController(contactService: mockContactService);

  List<Contact> contacts = <Contact>[
    Contact(
        shareLocation: false,
        available: true,
        id: "1",
        name: "Test 1",
        email: "test1@mail.com",
        imageUrl: "image1",
        phone: "123456781"),
    Contact(
        shareLocation: false,
        available: false,
        id: "2",
        name: "Test 2",
        email: "test2@mail.com",
        imageUrl: "image2",
        phone: "123456782"),
    Contact(
        shareLocation: false,
        available: true,
        id: "3",
        name: "Test 3",
        email: "test3@mail.com",
        imageUrl: "image3",
        phone: "123456783"),
    Contact(
        shareLocation: false,
        available: true,
        id: "4",
        name: "Test 4",
        email: "test4@mail.com",
        imageUrl: "image4",
        phone: "123456784"),
    Contact(
        shareLocation: false,
        available: false,
        id: "5",
        name: "Test 5",
        email: "test5@mail.com",
        imageUrl: "image5",
        phone: "123456785"),
  ];

  when(mockContactService.getAll()).thenAnswer((_) => Future.value(contacts));
  setUpAll(() async {});

  test('Check init contact list and its update', () async {
    expect(controller.allContacts, []);
    await controller.updateContacts();
    expect(controller.allContacts.length, 5);
  });

  test('Get available and unavailable contacts', () async {
    await controller.updateContacts();
    expect(controller.availableContacts.length, 3);
    expect(controller.unavailableContacts.length, 2);
  });

  test('Filter contacts', () async {
    await controller.updateContacts();
    controller.setTextFilter("1");
    expect(controller.textFilter, "1");
    expect(controller.filteredContacts.length, 1);
    expect(controller.filteredContacts[0].id, "1");
  });
}
