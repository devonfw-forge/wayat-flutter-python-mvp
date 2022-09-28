import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

part 'friends_controller.g.dart';

// ignore: library_private_types_in_public_api
class FriendsController = _FriendsController with _$FriendsController;

abstract class _FriendsController with Store {
  final ContactService _service;
  String textFilter = "";

  List<Contact> allContacts = List.empty();

  @observable
  ObservableList<Contact> filteredContacts = ObservableList.of(List.empty());

  _FriendsController({ContactService? contactService})
      : _service = contactService ?? ContactServiceImpl();

  @computed
  List<Contact> get availableContacts =>
      allContacts.where((contact) => contact.available).toList();

  @computed
  List<Contact> get unavailableContacts =>
      allContacts.where((contact) => !contact.available).toList();

  @action
  Future<void> updateContacts() async {
    List<Contact> newContacts = await _service.getAll();
    if (ListUtilsService.haveDifferentElements(allContacts, newContacts)) {
      allContacts = ObservableList.of(newContacts);
      filteredContacts = ObservableList.of(allContacts
          .where((element) =>
              element.name.toLowerCase().contains(textFilter.toLowerCase()))
          .toList());
      return;
    }
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
    filteredContacts.remove(contact);
    _service.removeContact(contact);
  }
}
