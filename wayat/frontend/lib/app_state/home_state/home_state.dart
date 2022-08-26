import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';

part 'home_state.g.dart';

// ignore: library_private_types_in_public_api
class HomeState = _HomeState with _$HomeState;

abstract class _HomeState with Store {
  @observable
  Contact? selectedContact;

  String navigationSourceContactProfile = "";

  @action
  void setSelectedContact(Contact? newContact, String navigationSource) {
    selectedContact = newContact;
    navigationSourceContactProfile = navigationSource;
  }
}
