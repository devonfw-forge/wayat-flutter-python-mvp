import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as addressBookContact;

class ContactServiceImpl extends ContactService {
  @override
  Future<List<Contact>> getAll() async {
    if (await addressBookContact.FlutterContacts.requestPermission()) {
      var contacts = await addressBookContact.FlutterContacts.getContacts(
              withProperties: true, withPhoto: true)
          .then((contact) {
        return Contact(
            available: true,
            displayName: contact.displayName,
            username: "active",
            email: "user@mail.com",
            imageUrl: "url");
      });
      return contacts;
    }
  }
}
