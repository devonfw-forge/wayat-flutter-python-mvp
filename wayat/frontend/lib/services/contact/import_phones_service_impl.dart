import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsAddressServiceImpl {
  static Future<List<String>> getAllPhones() async {
    try {
      if (await FlutterContacts.requestPermission(readonly: true)) {
        List<Contact> contacts =
            await FlutterContacts.getContacts(withProperties: true);
        return contacts
            .expand((contact) => contact.phones.map((e) => e.number))
            .map((e) => e.toString())
            .toList();
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}
