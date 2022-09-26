import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:wayat/services/contact/flutter_contacts_handler_libw.dart';

class ContactsAddressServiceImpl {
  static Future<List<String>> getAllPhones(
      {FlutterContactsHandlerLibW? handler}) async {
    FlutterContactsHandlerLibW contactsHandler =
        handler ?? FlutterContactsHandlerLibW();
    if (await contactsHandler.requestPermission()) {
      List<Contact> contacts = await contactsHandler.getContacts();
      return contacts
          .expand((contact) => contact.phones.map((e) => e.number))
          .map((e) => e.toString())
          .toList();
    }
    return [];
  }
}
