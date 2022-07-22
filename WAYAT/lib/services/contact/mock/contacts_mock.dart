import 'package:wayat/domain/contact/contact.dart';

class ContactsMock {
  static final List<Contact> contacts = [
    Contact(
        available: true,
        displayName: "User active",
        username: "active",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: true,
        displayName: "User pepe",
        username: "pepe",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: false,
        displayName: "Pepe USer",
        username: "pepeuser",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: true,
        displayName: "Name",
        username: "name",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: false,
        displayName: "DisplayName User",
        username: "display",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: true,
        displayName: "Test test",
        username: "test",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: false,
        displayName: "Test testing",
        username: "testing",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: true,
        displayName: "Testing testing",
        username: "testingtesting",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: false,
        displayName: "Testing test",
        username: "testingtest",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: true,
        displayName: "User the second",
        username: "USERsecond",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: true,
        displayName: "User the third",
        username: "third",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: false,
        displayName: "User the fourth",
        username: "fourth",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: true,
        displayName: "User the fifth",
        username: "fifth",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: false,
        displayName: "User the barbarian",
        username: "barbarian",
        email: "user@mail.com",
        imageUrl: "url"),
    Contact(
        available: true,
        displayName: "User the wise",
        username: "wise",
        email: "user@mail.com",
        imageUrl: "url"),
  ];

  static List<Contact> availableContacts() {
    return contacts.where((contact) => contact.available).toList();
  }

  static List<Contact> unavailableContacts() {
    return contacts.where((contact) => !contact.available).toList();
  }
}
