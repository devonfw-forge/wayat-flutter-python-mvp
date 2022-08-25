import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsAddressServiceImpl {
  static Future<List<String>> getAllPhones() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      return contacts
          .expand((contact) => contact.phones.map((e) => e.number))
          .map((e) => e.toString())
          .toList();
    }
    return List.empty();
  }
}
