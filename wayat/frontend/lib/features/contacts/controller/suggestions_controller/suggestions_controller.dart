import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/contact/contact_address_book.dart';
import 'package:wayat/features/contacts/controller/page_controller/contacts_page_controller.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/contact_address_book/contact_address_book_service_impl.dart';

part 'suggestions_controller.g.dart';

class SuggestionsController = _SuggestionsController
    with _$SuggestionsController;

abstract class _SuggestionsController with Store {
  ContactService contactsService = ContactServiceImpl();

  @observable
  List<Contact> suggestedContacts = [];

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
    suggestedContacts =
        (await contactsService.getFilteredContacts(adBookContacts));
  }
}
