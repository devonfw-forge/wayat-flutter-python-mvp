import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
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

  _OnboardingController(
      {ContactsAddressServiceImpl? addressServiceImpl,
      ContactService? contactService})
      : importContactService =
            addressServiceImpl ?? ContactsAddressServiceImpl(),
        contactService = contactService ?? ContactServiceImpl() {
    importContacts();
  }

  /// Import all contacts from user device
  void importContacts() async {
    List<String> importedContacts = await importContactService.getAllPhones();
    List<Contact> filteredContacts =
        await contactService.getFilteredContacts(importedContacts);
    addAll(filteredContacts);
  }

  /// State of the onboarding process
  @observable
  OnBoardingState onBoardingState = OnBoardingState.notStarted;

  /// Current onboarding page
  @observable
  OnBoardingProgress currentPage = OnBoardingProgress.initialManageContactsTip;

  @observable
  ObservableMap<Contact, bool> contacts = ObservableMap();

  /// Get contacts list
  @computed
  List<Contact> get contactList => contacts.keys.toList();

  /// Get selected contacts
  @computed
  List<Contact> get selectedContacts =>
      contacts.keys.where((element) => contacts[element]!).toList();

  /// Get unselected contacts
  @computed
  List<Contact> get unselectedContacts =>
      contacts.keys.where((element) => !contacts[element]!).toList();

  /// Whether contact is selected
  bool isSelected(Contact contact) {
    return selectedContacts.contains(contact);
  }

  /// Finish onboarding and update user session state
  void finishOnBoarding() {
    contactService.sendRequests(selectedContacts);
    UserState userState = GetIt.I.get<UserState>();
    userState.authService.sendDoneOnboarding();
    userState.currentUser!.onboardingCompleted = true;
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
