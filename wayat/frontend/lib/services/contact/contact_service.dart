import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';
import 'package:wayat/services/request/request_service.dart';
import 'package:wayat/services/service.dart';

abstract class ContactService extends RequestService {
  List<Contact> getAll();
  void sendRequests(List<Contact> contacts);
  Future<List<Contact>> getFilteredContacts(
      List<ContactAdressBook> importedContacts);
}
