import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/service.dart';

abstract class ContactService extends Service {
  List<Contact> getAll();
}
