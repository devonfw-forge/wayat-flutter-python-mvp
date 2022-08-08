import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/service.dart';

abstract class ContactService extends Service {
  List<Contact> getAll();
  void sendRequests(List<Contact> contacts);
  void setUpContactsListener(
      Function(List<ContactLocation> newContacts) onContactsUpdate);
}
