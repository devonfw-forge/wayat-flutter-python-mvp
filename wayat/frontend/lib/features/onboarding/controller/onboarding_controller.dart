import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';

part 'onboarding_controller.g.dart';

class OnboardingController = _OnboardingController with _$OnboardingController;

abstract class _OnboardingController with Store {
  @observable
  int currentPage = 1;

  @observable
  ObservableMap<Contact, bool> contacts = ObservableMap();

  @computed
  List<Contact> get contactList => contacts.keys.toList();

  @computed
  List<Contact> get selectedContacts =>
      contacts.keys.where((element) => contacts[element]!).toList();

  @computed
  List<Contact> get unselectedContacts =>
      contacts.keys.where((element) => !contacts[element]!).toList();

  @action
  void moveToPage(int newPage) {
    currentPage = newPage;
  }

  @action
  void updateSelected(Contact contact) {
    contacts[contact] = !contacts[contact]!;
  }

  @action
  void addAll(List<Contact> contactList) {
    for (var contact in contactList) {
      contacts[contact] = false;
    }
  }
}
