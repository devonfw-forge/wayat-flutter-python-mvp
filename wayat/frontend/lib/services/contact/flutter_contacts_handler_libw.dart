import 'package:flutter_contacts/flutter_contacts.dart';

class FlutterContactsHandlerLibW {
  Future<bool> requestPermission() async {
    return await FlutterContacts.requestPermission(readonly: true);
  }

  Future<List<Contact>> getContacts() async {
    return await FlutterContacts.getContacts(withProperties: true);
  }
}
