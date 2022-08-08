import 'package:mobx/mobx.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';

class _ContactsLocationState with Store {
  ContactService contactService = ContactServiceImpl();

  @observable
  List<ContactLocation> contacts = [];

  @action
  void setContactList(List<ContactLocation> newContacts) {
    contacts = newContacts;
  }

  void fetchContacts() {}
}
