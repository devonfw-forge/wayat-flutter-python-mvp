import 'package:wayat/domain/contact/contact.dart';

abstract class ContactService {
  Future<List<Contact>> getAll();

  Future<void> sendRequests(List<Contact> contacts);

  Future<List<Contact>> getFilteredContacts(List<String> importedContacts);

  Future<bool> removeContact(Contact contact);
}
