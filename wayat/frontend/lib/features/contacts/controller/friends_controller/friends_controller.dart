import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';

part 'friends_controller.g.dart';

// ignore: library_private_types_in_public_api
class FriendsController = _FriendsController with _$FriendsController;

abstract class _FriendsController with Store {
  final ContactService _service = ContactServiceImpl();

  @observable
  ObservableList<Contact> contacts = ObservableList.of(List.empty());

  @computed
  List<Contact> get availableContacts =>
      contacts.where((contact) => contact.available).toList();

  @computed
  List<Contact> get unavailableContacts =>
      contacts.where((contact) => !contact.available).toList();

  @action
  Future updateContacts() async {
    contacts = ObservableList.of(await _service.getAll());
  }

  @action
  void removeContact(Contact contact) {
    //TODO: UNCOMMENT THIS CODE WHEN THE REMOVE IS IMPLEMENTED IN THE SERVER
/*     _contacts.remove(contact);
    _service.removeContact(contact); */
  }
}
