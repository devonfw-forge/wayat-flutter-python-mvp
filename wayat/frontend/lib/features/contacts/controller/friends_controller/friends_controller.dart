import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

part 'friends_controller.g.dart';

/// Controller containing business logic for Friends tab inside contacts page
// ignore: library_private_types_in_public_api
class FriendsController = _FriendsController with _$FriendsController;

/// Base Controller for friends tab using MobX
abstract class _FriendsController with Store {
  /// Service providing contacts information of current user.
  final ContactService _service;

  /// Text filter containing query of a searchbar to filter contacts
  String textFilter = "";

  /// List of all contacts of user without filtering.
  List<Contact> allContacts = List.empty();

  /// List of filtered contacts
  @observable
  ObservableList<Contact> filteredContacts = ObservableList.of(List.empty());

  _FriendsController({ContactService? contactService})
      : _service = contactService ?? ContactServiceImpl();

  /// Update the list all your contacts, including the ones that user just accepts or viceversa.
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

  /// Sets the text filter to perform the query in contacts list
  @action
  void setTextFilter(String text) {
    textFilter = text;
    filteredContacts = ObservableList.of(allContacts
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }

  /// Remove contact from user's friends list.
  @action
  Future<void> removeContact(Contact contact) async {
    allContacts.remove(contact);
    filteredContacts.remove(contact);
    _service.removeContact(contact);
  }
}
