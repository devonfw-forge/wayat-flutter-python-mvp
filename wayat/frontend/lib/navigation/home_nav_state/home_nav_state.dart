import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';

part 'home_nav_state.g.dart';

// ignore: library_private_types_in_public_api
class HomeNavState = _HomeNavState with _$HomeNavState;

/// Controls whether the [HomePage] or the [ContactProfilePage] is showed
abstract class _HomeNavState with Store {
  /// If this is not null, the [ContactProfilePage] will be showed
  @observable
  Contact? selectedContact;

  /// Defines where was the [ContactProfilePage] accessed from
  ///
  /// If it was accessed from the [ContactDialog] in the map,
  /// the value would be `wayat`. If it was accessed from the [FriendsPage],
  /// the value would be `Contacts`
  String navigationSourceContactProfile = "";

  /// Updates [selectedContact] and [navigationSource]
  ///
  /// [navigationSource] should be an empty String if [newContact] is null
  @action
  void setSelectedContact(Contact? newContact, String navigationSource) {
    selectedContact = newContact;
    navigationSourceContactProfile = navigationSource;
  }
}
