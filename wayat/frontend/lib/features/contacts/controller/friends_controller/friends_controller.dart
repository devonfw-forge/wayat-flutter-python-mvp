import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';

part 'friends_controller.g.dart';

// ignore: library_private_types_in_public_api
class FriendsController = _FriendsController with _$FriendsController;

abstract class _FriendsController with Store {
  final ContactService _service = ContactServiceImpl();
  String textFilter = "";

  ObservableList<Contact> allContacts = ObservableList.of(List.empty());

  @observable
  ObservableList<Contact> filteredContacts = ObservableList.of(List.empty());

  @computed
  List<Contact> get availableContacts =>
      allContacts.where((contact) => contact.available).toList();

  @computed
  List<Contact> get unavailableContacts =>
      allContacts.where((contact) => !contact.available).toList();

  @action
  Future<void> updateContacts() async {
    allContacts = ObservableList.of(await _service.getAll());
    filteredContacts = ObservableList.of(allContacts
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }

  @action
  void setTextFilter(String text) {
    textFilter = text;
    filteredContacts = ObservableList.of(allContacts
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }

  @action
  Future<void> removeContact(Contact contact) async {
    allContacts.remove(contact);
    _service.removeContact(contact);
  }
}
