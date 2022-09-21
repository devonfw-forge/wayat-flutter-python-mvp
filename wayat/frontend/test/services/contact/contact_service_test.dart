import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';
import 'package:http/http.dart' as http;

import 'contact_service_test.mocks.dart';

@GenerateMocks([HttpProvider, http.Response])
void main() async {
  HttpProvider mockHttpProvider = MockHttpProvider();
  Map<String, dynamic> getContactsReponse = {
    "users": [
      {
        "id": "TESTID12345",
        "phone": "+34123456789",
        "name": "User Cap",
        "image_url": "https://example.com/image1"
      },
      {
        "id": "TESTID123456",
        "phone": "+34987654321",
        "name": "User Cap 2",
        "image_url": "https://example.com/image2"
      }
    ]
  };
  List<Contact> contactList = [
    Contact(
        shareLocation: true,
        available: false,
        id: 'TESTID12345',
        name: 'User Cap',
        email: '',
        imageUrl: "https://example.com/image1",
        phone: "+34123456789"),
    Contact(
        shareLocation: true,
        available: false,
        id: 'TESTID123456',
        name: 'User Cap 2',
        email: '',
        imageUrl: "https://example.com/image2",
        phone: "+34987654321")
  ];

  setUpAll(() {
    when(mockHttpProvider.sendGetRequest(APIContract.contacts))
        .thenAnswer((_) => Future.value(getContactsReponse));

    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
  });

  test("getAll returns a correct list", () async {
    ContactService contactService = ContactServiceImpl();

    List<Contact> result = await contactService.getAll();

    expect(contactList, result);
  });

  test("Send Requests calls the correct endpoint with correct data", () async {
    when(mockHttpProvider.sendPostRequest(APIContract.addContact, {
      "users": ["TESTID12345", "TESTID123456"]
    })).thenAnswer((_) => Future.value(MockResponse()));

    ContactService contactService = ContactServiceImpl();

    await contactService.sendRequests(contactList);

    verify(mockHttpProvider.sendPostRequest(APIContract.addContact, {
      "users": ["TESTID12345", "TESTID123456"]
    })).called(1);
  });

  test("Filtered contacts are returned correctly", () async {
    List<String> importedNumbers = ["(+34) 123 456 789", "+34-987654321"];
    http.Response filterResponse = MockResponse();
    when(filterResponse.bodyBytes).thenReturn(
        Uint8List.fromList(jsonEncode(getContactsReponse).codeUnits));

    when(mockHttpProvider.sendPostRequest(APIContract.findByPhone, {
      "phones": ["+34123456789", "+34987654321"]
    })).thenAnswer((_) => Future.value(filterResponse));

    ContactService contactService = ContactServiceImpl();

    List<Contact> filteredContacts =
        await contactService.getFilteredContacts(importedNumbers);

    expect(filteredContacts, contactList);
    verify(mockHttpProvider.sendPostRequest(APIContract.findByPhone, {
      "phones": ["+34123456789", "+34987654321"]
    })).called(1);
  });

  test("Remove contact calls the correct endpoint with correct data", () async {
    Contact contactToRemove = contactList.first;
    when(mockHttpProvider
            .sendDelRequest("${APIContract.contacts}/${contactToRemove.id}"))
        .thenAnswer((_) => Future.value(true));

    ContactService contactService = ContactServiceImpl();

    await contactService.removeContact(contactToRemove);

    verify(mockHttpProvider
            .sendDelRequest("${APIContract.contacts}/${contactToRemove.id}"))
        .called(1);
  });
}
