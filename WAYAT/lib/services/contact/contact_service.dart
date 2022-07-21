import 'package:wayat/contacts/mock/contacts_mock.dart';
import 'package:wayat/domain/contact.dart';
import 'package:wayat/services/service.dart';

abstract class ContactService extends Service {
  List<Contact> getAll();
}
