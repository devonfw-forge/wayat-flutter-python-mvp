import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/contact/import_phones_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

part 'suggestions_controller.g.dart';

/// Controller containing business logic for Suggestions tab inside contacts page
// ignore: library_private_types_in_public_api
class SuggestionsController = _SuggestionsController
    with _$SuggestionsController;

/// Base Controller for Suggestions tab using MobX
abstract class _SuggestionsController with Store {
  /// Service providing contacts information of current user.
  final ContactService contactsService;

  /// Friends Controller to access its logic
  final FriendsController friendsController;

  /// Requests Controller to access its logic
  final RequestsController requestsController;

  _SuggestionsController(
      {required this.friendsController,
      required this.requestsController,
      ContactService? contactsService})
      : contactsService = contactsService ?? ContactServiceImpl();

  /// Text filter containing query of a searchbar to filter contacts
  String textFilter = "";

  /// List of all suggested contacts using wayat in your addressbook of user without filtering
  List<Contact> allSuggestions = List<Contact>.of([]);

  /// List of all suggested contacts using wayat in your addressbook of user
  @observable
  ObservableList<Contact> filteredSuggestions = ObservableList.of([]);

  /// Sends request to a suggested contact and add it to sendRequest
  @action
  Future<void> sendRequest(Contact contact) async {
    allSuggestions.remove(contact);
    filteredSuggestions.remove(contact);
    requestsController.sendRequest(contact);
  }

  /// Updates list of suggested contacts from your addressBook
  @action
  Future updateSuggestedContacts(
      {ContactsAddressServiceImpl? contactsAddressServiceImpl}) async {
    ContactsAddressServiceImpl contactsAddressServiceLibW =
        contactsAddressServiceImpl ?? ContactsAddressServiceImpl();
    List<String> adBookContacts =
        await contactsAddressServiceLibW.getAllPhones();
    await requestsController.updateRequests();
    List<Contact> newSuggestions =
        (await contactsService.getFilteredContacts(adBookContacts))
            .where((element) =>
                !friendsController.allContacts.contains(element) &&
                !requestsController.sentRequests.contains(element))
            .toList();
    if (ListUtilsService.haveDifferentElements(
        newSuggestions, allSuggestions)) {
      allSuggestions = newSuggestions;
      filteredSuggestions = ObservableList.of(allSuggestions
          .where((element) =>
              element.name.toLowerCase().contains(textFilter.toLowerCase()))
          .toList());
    }
  }

  /// Sets the text filter to perform the query in contacts list
  @action
  @action
  void setTextFilter(String text) {
    textFilter = text;
    filteredSuggestions = ObservableList.of(allSuggestions
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }

  /// Copies platform text to invite to wayat
  Future copyInvitation() async {
    await Clipboard.setData(ClipboardData(text: platformText()));
  }

  /// Returns invite text for target platform
  ///
  /// Returns an empty text for platforms not included in Android or IOS
  @visibleForTesting
  String platformText([PlatformService? platformService]) {
    platformService ??= PlatformService();
    if (platformService.targetPlatform == TargetPlatform.android) {
      return appLocalizations.invitationTextAndroid;
    }
    if (platformService.targetPlatform == TargetPlatform.iOS) {
      return appLocalizations.invitationTextIOS;
    }
    return '';
  }
}
