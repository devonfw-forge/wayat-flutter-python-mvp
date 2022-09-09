import 'package:wayat/domain/contact/contact.dart';

class ContactsMock {
  static final List<Contact> contacts = [
    Contact(
        id: "",
        available: true,
        shareLocation: true,
        name: "User active",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        id: "",
        available: true,
        shareLocation: true,
        name: "User pepe",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        id: "",
        available: false,
        shareLocation: true,
        name: "Pepe USer",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        id: "",
        available: true,
        shareLocation: true,
        name: "Name",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        id: "",
        available: false,
        shareLocation: true,
        name: "DisplayName User",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        id: "",
        available: true,
        shareLocation: true,
        name: "Test test",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        available: false,
        shareLocation: true,
        id: "",
        name: "Test testing",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        available: true,
        shareLocation: true,
        name: "Testing testing",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        id: "",
        phone: "+34123456789"),
    Contact(
        available: false,
        shareLocation: true,
        name: "Testing test",
        id: "",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        available: true,
        shareLocation: true,
        name: "User the second",
        email: "user@mail.com",
        id: "",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        available: true,
        shareLocation: true,
        name: "User the third",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        id: "",
        phone: "+34123456789"),
    Contact(
        available: false,
        shareLocation: true,
        name: "User the fourth",
        email: "user@mail.com",
        id: "",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        available: true,
        shareLocation: true,
        name: "User the fifth",
        email: "user@mail.com",
        id: "",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
    Contact(
        available: false,
        shareLocation: true,
        name: "User the barbarian",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        id: "",
        phone: "+34123456789"),
    Contact(
        available: true,
        shareLocation: true,
        name: "User the wise",
        id: "",
        email: "user@mail.com",
        imageUrl:
            "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50",
        phone: "+34123456789"),
  ];

  static List<Contact> availableContacts() {
    return contacts.where((contact) => contact.available).toList();
  }

  static List<Contact> unavailableContacts() {
    return contacts.where((contact) => !contact.available).toList();
  }
}
