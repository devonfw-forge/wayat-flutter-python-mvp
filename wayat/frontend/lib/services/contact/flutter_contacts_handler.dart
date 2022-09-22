import 'package:flutter_contacts/flutter_contacts.dart';

class FlutterContactsHandler {
  Future<bool> requestPermission() async {
    return await FlutterContacts.requestPermission(readonly: true);
  }

  Future<List<Contact>> getContacts() async {
    return await FlutterContacts.getContacts(withProperties: true);
  }
}
