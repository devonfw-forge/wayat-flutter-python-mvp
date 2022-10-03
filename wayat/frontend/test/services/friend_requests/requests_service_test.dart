import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/friend_requests/requests_service.dart';
import 'package:wayat/services/friend_requests/requests_service_impl.dart';
import 'package:http/http.dart' as http;

import 'requests_service_test.mocks.dart';

@GenerateMocks([HttpProvider, http.Response])
void main() async {
  HttpProvider mockHttpProvider = MockHttpProvider();
  Map<String, dynamic> getRequestsResponse = {
    "sent_requests": [
      {
        "id": "TESTID12345",
        "phone": "+34123456789",
        "name": "Test User",
        "image_url": "https://example.com/image1"
      },
      {
        "id": "TESTID123456",
        "phone": "+34666666666",
        "name": "Test User Second",
        "image_url": "https://example.com/image2"
      }
    ],
    "pending_requests": [
      {
        "id": "TESTID1234567",
        "phone": "+34987654321",
        "name": "Test User Third",
        "image_url": "https://example.com/image3"
      },
      {
        "id": "TESTID12345678",
        "phone": "+34123459876",
        "name": "Test User Fourth",
        "image_url": "https://example.com/image4"
      }
    ]
  };

  List<Contact> sentRequestsContacts = [
    Contact(
        shareLocationTo: true,
        id: 'TESTID12345',
        name: 'Test User',
        email: '',
        imageUrl: "https://example.com/image1",
        phone: "+34123456789"),
    Contact(
        shareLocationTo: true,
        id: 'TESTID123456',
        name: 'Test User Second',
        email: '',
        imageUrl: "https://example.com/image2",
        phone: "+34666666666"),
  ];

  List<Contact> pendingRequestsContacts = [
    Contact(
        shareLocationTo: true,
        id: 'TESTID1234567',
        name: 'Test User Third',
        email: '',
        imageUrl: "https://example.com/image3",
        phone: "+34987654321"),
    Contact(
        shareLocationTo: true,
        id: 'TESTID12345678',
        name: 'Test User Fourth',
        email: '',
        imageUrl: "https://example.com/image4",
        phone: "+34123459876"),
  ];

  setUpAll(() {
    GetIt.I.registerSingleton<HttpProvider>(mockHttpProvider);
  });

  test("GetRequests returns correct data and calls correct endpoint", () async {
    when(mockHttpProvider.sendGetRequest(APIContract.friendRequests))
        .thenAnswer((_) => Future.value(getRequestsResponse));

    RequestsService requestsService = RequestsServiceImpl();

    Map<String, List<Contact>> result = await requestsService.getRequests();

    expect(result, {
      "pending_requests": pendingRequestsContacts,
      "sent_requests": sentRequestsContacts
    });
  });

  test("SendRequests calls the correct endpoint with correct data", () async {
    http.Response mockResponse = MockResponse();
    when(mockResponse.statusCode).thenReturn(200);

    List<Contact> allContacts = [];
    allContacts.addAll(pendingRequestsContacts);
    allContacts.addAll(sentRequestsContacts);
    List<String> contactIds = allContacts.map((contact) => contact.id).toList();

    when(mockHttpProvider
            .sendPostRequest(APIContract.addContact, {"users": contactIds}))
        .thenAnswer((_) => Future.value(mockResponse));

    RequestsService requestsService = RequestsServiceImpl();

    bool result = await requestsService.sendRequests(allContacts);

    expect(result, true);
    verify(mockHttpProvider.sendPostRequest(
        APIContract.addContact, {"users": contactIds})).called(1);
  });

  test("AcceptRequest calls the correct endpoint with correct data", () async {
    http.Response mockResponse = MockResponse();
    when(mockResponse.statusCode).thenReturn(200);

    Contact contact = pendingRequestsContacts.first;

    when(mockHttpProvider.sendPostRequest(
            APIContract.friendRequests, {"uid": contact.id, "accept": true}))
        .thenAnswer((_) => Future.value(mockResponse));

    RequestsService requestsService = RequestsServiceImpl();

    bool result = await requestsService.acceptRequest(contact);

    expect(result, true);
    verify(mockHttpProvider.sendPostRequest(
            APIContract.friendRequests, {"uid": contact.id, "accept": true}))
        .called(1);
  });

  test("RejectRequest calls the correct endpoint with correct data", () async {
    http.Response mockResponse = MockResponse();
    when(mockResponse.statusCode).thenReturn(200);

    Contact contact = pendingRequestsContacts.first;

    when(mockHttpProvider.sendPostRequest(
            APIContract.friendRequests, {"uid": contact.id, "accept": false}))
        .thenAnswer((_) => Future.value(mockResponse));

    RequestsService requestsService = RequestsServiceImpl();

    bool result = await requestsService.rejectRequest(contact);

    expect(result, true);
    verify(mockHttpProvider.sendPostRequest(
            APIContract.friendRequests, {"uid": contact.id, "accept": false}))
        .called(1);
  });

  test("SendRequest calls the correct endpoint with correct data", () async {
    http.Response mockResponse = MockResponse();
    when(mockResponse.statusCode).thenReturn(200);

    Contact contact = pendingRequestsContacts.first;

    when(mockHttpProvider.sendPostRequest(APIContract.addContact, {
      "users": [contact.id]
    })).thenAnswer((_) => Future.value(mockResponse));

    RequestsService requestsService = RequestsServiceImpl();

    bool result = await requestsService.sendRequest(contact);

    expect(result, true);
    verify(mockHttpProvider.sendPostRequest(APIContract.addContact, {
      "users": [contact.id]
    })).called(1);
  });

  test("UnsendRequest calls the correct endpoint with correct data", () async {
    http.Response mockResponse = MockResponse();
    when(mockResponse.statusCode).thenReturn(200);

    Contact contact = pendingRequestsContacts.first;

    when(mockHttpProvider
            .sendDelRequest("${APIContract.sentFriendRequests}/${contact.id}"))
        .thenAnswer((_) => Future.value(true));

    RequestsService requestsService = RequestsServiceImpl();

    bool result = await requestsService.unsendRequest(contact);

    expect(result, true);
    verify(mockHttpProvider
            .sendDelRequest("${APIContract.sentFriendRequests}/${contact.id}"))
        .called(1);
  });
}
