import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/controller/onboarding_state.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/import_phones_service_impl.dart';

import 'onboarding_controller_test.mocks.dart';

@GenerateMocks([
  OnboardingController,
  ContactsAddressServiceImpl,
  ContactService
])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ContactService mockContactService;
  late OnboardingController onboardingController;
  late ContactsAddressServiceImpl mockContactsAddressServiceImpl;
  Contact contactA = _contactFactory('ContactA');
  Contact contactB = _contactFactory('ContactB');
  setUpAll(() {
    mockContactService = MockContactService();
    mockContactsAddressServiceImpl = MockContactsAddressServiceImpl();
    when(mockContactsAddressServiceImpl.getAllPhones()).thenAnswer((_) async => ['1','2','3']);
    when(mockContactService.getFilteredContacts(['1','2','3'])).thenAnswer((_) async => []);
    onboardingController = OnboardingController(addressServiceImpl: mockContactsAddressServiceImpl, contactService: mockContactService);
    when(mockContactService.sendRequests([])).thenAnswer((_) => Future.value(null));
  });

  test('isSelected and not contains contact returns false', () {
    bool expected = onboardingController.isSelected(contactA);
    expect(expected, false);
  });

  test('isSelected and contains contact returns true', () async {
    onboardingController.addAll([contactA,contactB]);
    onboardingController.updateSelected(contactA);
    bool expected = onboardingController.isSelected(contactA);
    expect(expected, true);
  });

  test('setOnboardingState change onBoardingState to the correct value', () {
    OnBoardingState state = OnBoardingState.current;
    onboardingController.setOnBoardingState(state);
    expect(onboardingController.onBoardingState, state);
  });

  test('progressTo change the currentPage to the correct value', () {
    OnBoardingProgress page = OnBoardingProgress.sendRequests;
    onboardingController.progressTo(page);
    expect(onboardingController.currentPage, page);
  });

  test('moveBack returns false when currentPage is initialManageContactsTips', () {
    OnBoardingProgress page = OnBoardingProgress.initialManageContactsTip;
    onboardingController.progressTo(page);
    bool expected = onboardingController.moveBack();
    expect(expected, false);
  });

  test('moveBack returns true and moves to initialManageContactsTips when currentPage is importAddressBookContacts', () {
    OnBoardingProgress page = OnBoardingProgress.importAddressBookContacts;
    onboardingController.progressTo(page);
    bool expected = onboardingController.moveBack();
    expect(expected, true);
    expect(onboardingController.currentPage, OnBoardingProgress.initialManageContactsTip);
  });

  test('moveBack returns true and moves to importAddressBookContacts when currentPage is sendRequests', () {
    OnBoardingProgress page = OnBoardingProgress.sendRequests;
    onboardingController.progressTo(page);
    bool expected = onboardingController.moveBack();
    expect(expected, true);
    expect(onboardingController.currentPage, OnBoardingProgress.importAddressBookContacts);
  });

  test('contactList has the correct key values', () {
    mobx.ObservableMap<Contact, bool> contactListTest = mobx.ObservableMap.of({contactA:true,contactB:false});
    onboardingController.contacts = contactListTest;
    expect(onboardingController.contactList, [contactA, contactB]);
  });

  test('unselectedContacts has the correct key values', () {
    mobx.ObservableMap<Contact, bool> contactListTest = mobx.ObservableMap.of({contactA:true,contactB:false});
    onboardingController.contacts = contactListTest;
    expect(onboardingController.unselectedContacts, [contactB]);
  });

}

Contact _contactFactory(String contactName) {
  return Contact(
    available: true,
    shareLocation: true,
    id: "id $contactName",
    name: contactName,
    email: "Contact email",
    imageUrl: "https://example.com/image",
    phone: "123",
  );
}
