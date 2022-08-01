import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class ContactServiceImpl extends ContactService {
  @override
  List<Contact> getAll() {
    return ContactsMock.contacts;
  }

  @override
  void sendRequests(List<Contact> contacts) {
    //TODO: SEND REQUESTS TO BACKEND
  }
}
