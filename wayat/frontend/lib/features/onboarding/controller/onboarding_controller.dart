import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:wayat/services/first_launch/first_launch_service.dart';

part 'onboarding_controller.g.dart';

class OnboardingController = _OnboardingController with _$OnboardingController;

abstract class _OnboardingController with Store {
  ContactService contactService = ContactServiceImpl();
  FirstLaunchService firstLaunchService = FirstLaunchService();

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
    debugPrint(selectedContacts.toString());
    debugPrint(contact.toString());
    return selectedContacts.contains(contact);
  }

  void finishOnBoarding(BuildContext context) {
    contactService.sendRequests(selectedContacts);
    firstLaunchService.setFinishedOnBoarding();
    AutoRouter.of(context).push(LaunchRoute());
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
}
