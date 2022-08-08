import 'package:wayat/domain/contact/contact.dart';

class ContactsMock {
  static final List<Contact> contacts = [
    Contact(
        available: true,
        name: "User active",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: true,
        name: "User pepe",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: false,
        name: "Pepe USer",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: true,
        name: "Name",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: false,
        name: "DisplayName User",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: true,
        name: "Test test",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: false,
        name: "Test testing",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: true,
        name: "Testing testing",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: false,
        name: "Testing test",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: true,
        name: "User the second",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: true,
        name: "User the third",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: false,
        name: "User the fourth",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: true,
        name: "User the fifth",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: false,
        name: "User the barbarian",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
    Contact(
        available: true,
        name: "User the wise",
        email: "user@mail.com",
        imageUrl: "url",
        phone: "+34123456789"),
  ];

  static List<Contact> availableContacts() {
    return contacts.where((contact) => contact.available).toList();
  }

  static List<Contact> unavailableContacts() {
    return contacts.where((contact) => !contact.available).toList();
  }
}
