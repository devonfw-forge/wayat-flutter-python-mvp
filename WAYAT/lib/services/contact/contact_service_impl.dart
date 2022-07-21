import 'package:wayat/contacts/mock/contacts_mock.dart';
import 'package:wayat/domain/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';

class ContactServiceImpl extends ContactService {
  @override
  List<Contact> getAll() {
    return ContactsMock.contacts;
  }
}
