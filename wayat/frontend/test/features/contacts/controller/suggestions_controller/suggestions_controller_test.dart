import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/import_phones_service_impl.dart';

import '../../../../test_common/test_app.dart';
import 'suggestions_controller_test.mocks.dart';

@GenerateMocks([
  ContactService,
  FriendsController,
  RequestsController,
  ContactsAddressServiceImpl,
])
void main() async {
  MockContactService mockContactService = MockContactService();
  MockFriendsController mockFriendsController = MockFriendsController();
  MockRequestsController mockRequestsController = MockRequestsController();

  SuggestionsController controller = SuggestionsController(
      friendsController: mockFriendsController,
      contactsService: mockContactService,
      requestsController: mockRequestsController);

  List<Contact> contacts = <Contact>[
    Contact(
        shareLocationTo: false,
        id: "1",
        name: "test_name 1",
        email: "test@mail.com",
        imageUrl: "url://image",
        phone: "600600600"),
    Contact(
        shareLocationTo: false,
        id: "2",
        name: "Test 2",
        email: "test2@mail.com",
        imageUrl: "image2",
        phone: "123456782"),
    Contact(
        shareLocationTo: false,
        id: "3",
        name: "Test 3",
        email: "test3@mail.com",
        imageUrl: "image3",
        phone: "123456783"),
    Contact(
        shareLocationTo: false,
        id: "4",
        name: "Test 4",
        email: "test4@mail.com",
        imageUrl: "image4",
        phone: "123456784"),
    Contact(
        shareLocationTo: false,
        id: "5",
        name: "Test 5",
        email: "test5@mail.com",
        imageUrl: "image5",
        phone: "123456785"),
  ];

  //Mock contacts in Address Book
  MockContactsAddressServiceImpl mockContactAddresServiceImpl =
      MockContactsAddressServiceImpl();
  List<String> contactsNum = ["666666666", "555555555", "444444444"];
  when(mockContactAddresServiceImpl.getAllPhones())
      .thenAnswer((_) => Future.value(contactsNum));

  //Mock contacts in friends
  when(mockFriendsController.allContacts).thenReturn([]);

  //Mock contacts that sent a request
  // First, mock update request
  when(mockRequestsController.updateRequests()).thenAnswer(Future.value);
  //Then mock request
  when(mockRequestsController.sentRequests)
      .thenReturn(mobx.ObservableList.of([]));

  //Mock filter contacts in Addres Book that have an account
  when(mockContactService.getFilteredContacts(any))
      .thenAnswer((_) => Future.value(contacts));

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
  });

  test('Update suggested contacts', () async {
    expect(controller.allSuggestions, []);
    await controller.updateSuggestedContacts(
        contactsAddressServiceImpl: mockContactAddresServiceImpl);
    expect(controller.allSuggestions.length, 5);
  });

  test('Check set set text filter', () async {
    await controller.updateSuggestedContacts(
        contactsAddressServiceImpl: mockContactAddresServiceImpl);
    controller.setTextFilter("Test 3");
    expect(controller.filteredSuggestions.length, 1);
    expect(controller.filteredSuggestions[0].id, "3");
  });

  testWidgets('Text invitation', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    await tester.pumpWidget(TestApp.createApp());
    expect(controller.platformText(), appLocalizations.invitationTextAndroid);
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(controller.platformText(), appLocalizations.invitationTextIOS);
    debugDefaultTargetPlatformOverride = null;
  });
}
