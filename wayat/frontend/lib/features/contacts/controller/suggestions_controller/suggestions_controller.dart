import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/contact_address_book/contact_address_book_service_impl.dart';

part 'suggestions_controller.g.dart';

// ignore: library_private_types_in_public_api
class SuggestionsController = _SuggestionsController
    with _$SuggestionsController;

abstract class _SuggestionsController with Store {
  ContactService contactsService = ContactServiceImpl();
  late FriendsController friendsController;

  _SuggestionsController(this.friendsController);

  String textFilter = "";

  List<Contact> allSuggestions = List.of([]);

  @observable
  ObservableList<Contact> filteredSuggestions = ObservableList.of([]);

  @action
  void sendRequest(Contact contact) {
    GetIt.I
        .get<ContactsPageController>()
        .requestsController
        .sendRequest(contact);
  }

  @action
  Future updateSuggestedContacts() async {
    List<ContactAdressBook> adBookContacts =
        await ContactsAddressServiceImpl.getAll();
    allSuggestions = (await contactsService.getFilteredContacts(adBookContacts))
        .where((element) => !friendsController.allContacts.contains(element))
        .toList();
    filteredSuggestions = ObservableList.of(allSuggestions
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }

  @action
  void setTextFilter(String text) {
    textFilter = text;
    filteredSuggestions = ObservableList.of(allSuggestions
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }
}
