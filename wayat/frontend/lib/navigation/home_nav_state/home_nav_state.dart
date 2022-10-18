// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';

part 'home_nav_state.g.dart';

// ignore: library_private_types_in_public_api
class HomeNavState = _HomeNavState with _$HomeNavState;

/// Controls whether the [HomePage] or the [ContactProfilePage] is showed
abstract class _HomeNavState with Store {
  /// If this is not null, the [ContactProfilePage] will be showed
  @observable
  Contact? selectedContact;

  /// Updates [selectedContact] and [navigationSource]
  ///
  /// [navigationSource] should be an empty String if [newContact] is null
  @action
  void setSelectedContact(Contact? newContact) {
    selectedContact = newContact;
  }

  Future<void> contactProfileGuard(String id) async {
    if (selectedContact != null && selectedContact?.id == id) {
      return;
    }
    FriendsController friendsController =
        GetIt.I.get<ContactsPageController>().friendsController;
    await friendsController.updateContacts();
    selectedContact = friendsController.allContacts
        .firstWhereOrNull((contact) => id == contact.id);
  }
}
