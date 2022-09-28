import 'package:flutter_contacts/flutter_contacts.dart';

/// Wrapper for the [FlutterContacts] library.
///
/// [FlutterContacts] allows us to read contacts from the user's phone.
///
/// This wrapper is necessary to be able to mock the libary's functionality for testing purposes.
class FlutterContactsHandlerLibW {
  Future<bool> requestPermission() async {
    return await FlutterContacts.requestPermission(readonly: true);
  }

  Future<List<Contact>> getContacts() async {
    return await FlutterContacts.getContacts(withProperties: true);
  }
}
