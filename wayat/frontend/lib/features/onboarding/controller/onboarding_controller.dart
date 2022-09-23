import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/controller/onboarding_state.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/contact/import_phones_service_impl.dart';

part 'onboarding_controller.g.dart';

// ignore: library_private_types_in_public_api
class OnboardingController = _OnboardingController with _$OnboardingController;

abstract class _OnboardingController with Store {
  final ContactsAddressServiceImpl importContactService;
  final ContactService contactService;

  _OnboardingController({ContactsAddressServiceImpl? addressServiceImpl, ContactService? contactService})
      : importContactService = addressServiceImpl ?? ContactsAddressServiceImpl(),
      contactService = contactService ?? ContactServiceImpl() {
    importContacts();
  }

  void importContacts() async {
    List<String> importedContacts =
        await importContactService.getAllPhones();
    List<Contact> filteredContacts =
        await contactService.getFilteredContacts(importedContacts);
    addAll(filteredContacts);
  }

  @observable
  OnBoardingState onBoardingState = OnBoardingState.notStarted;

  @observable
  OnBoardingProgress currentPage = OnBoardingProgress.initialManageContactsTip;

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

  bool isSelected(Contact contact) {
    return selectedContacts.contains(contact);
  }

  void finishOnBoarding() {
    contactService.sendRequests(selectedContacts);
    SessionState userSession = GetIt.I.get<SessionState>();
    userSession.doneOnBoarding();
  }

  @action
  void progressTo(OnBoardingProgress newPage) {
    currentPage = newPage;
  }

  @action
  bool moveBack() {
    if (currentPage == OnBoardingProgress.initialManageContactsTip) {
      return false;
    }

    if (currentPage == OnBoardingProgress.importAddressBookContacts) {
      currentPage = OnBoardingProgress.initialManageContactsTip;
    } else if (currentPage == OnBoardingProgress.sendRequests) {
      currentPage = OnBoardingProgress.importAddressBookContacts;
    }

    return true;
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

  @action
  void setOnBoardingState(OnBoardingState state) {
    onBoardingState = state;
  }
}
