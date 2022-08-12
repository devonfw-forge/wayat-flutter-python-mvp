import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';
import 'package:wayat/services/request/rest_service.dart';

abstract class ContactService extends RESTService {
  Future<List<Contact>> getAll();

  void sendRequests(List<Contact> contacts);

  Future<List<Contact>> getFilteredContacts(
      List<ContactAdressBook> importedContacts);
  void removeContact(Contact contact);
}
