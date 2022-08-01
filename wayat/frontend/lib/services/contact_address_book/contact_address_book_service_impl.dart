import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';

class ContactServiceImpl {
  static Future<List<ContactAdressBook>> getAll() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      return contacts
          .map((contact) => ContactAdressBook(
              name: contact.displayName,
              phoneNumber: contact.phones.first.number,
              photo: contact.photo))
          .toList();
    }
    return List.empty();
  }
}
