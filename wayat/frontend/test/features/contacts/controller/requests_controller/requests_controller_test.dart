import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/services/friend_requests/requests_service_impl.dart';

import 'requests_controller_test.mocks.dart';

@GenerateMocks([RequestsServiceImpl, FriendsController])
void main() async {
  MockRequestsServiceImpl mockRequestServiceImpl = MockRequestsServiceImpl();
  MockFriendsController mockFriendsController = MockFriendsController();
  RequestsController controller = RequestsController(
      requestsService: mockRequestServiceImpl,
      friendsController: mockFriendsController);

  Map<String, List<Contact>> getRequestsResponse = {
    "sent_requests": [
      Contact(
          shareLocation: false,
          available: true,
          id: "1",
          name: "Test 1",
          email: "test1@mail.com",
          imageUrl: "image1",
          phone: "123456781"),
      Contact(
          shareLocation: false,
          available: false,
          id: "2",
          name: "Test 2",
          email: "test2@mail.com",
          imageUrl: "image2",
          phone: "123456782"),
      Contact(
          shareLocation: false,
          available: true,
          id: "3",
          name: "Test 3",
          email: "test3@mail.com",
          imageUrl: "image3",
          phone: "123456783"),
    ],
    "pending_requests": [
      Contact(
          shareLocation: false,
          available: true,
          id: "4",
          name: "Test 4",
          email: "test4@mail.com",
          imageUrl: "image4",
          phone: "123456784"),
      Contact(
          shareLocation: false,
          available: false,
          id: "5",
          name: "Test 5",
          email: "test5@mail.com",
          imageUrl: "image5",
          phone: "123456785"),
    ]
  };

  when(mockRequestServiceImpl.getRequests())
      .thenAnswer((_) => Future.value(getRequestsResponse));
  when(mockRequestServiceImpl.sendRequest(any))
      .thenAnswer((_) => Future.value(true));

  setUpAll(() async {});

  test('Check update request', () async {
    expect(controller.pendingRequests, []);
    expect(controller.sentRequests, []);
    await controller.updateRequests();
    expect(controller.sentRequests.length, 3);
    expect(controller.pendingRequests.length, 2);
  });

  test('Send request to a friend', () async {
    await controller.updateRequests();
    Contact newContact = Contact(
        shareLocation: true,
        available: false,
        id: "11",
        name: "New contact",
        email: "newContact@mail.com",
        imageUrl: "imageContact",
        phone: "987654321");

    await controller.sendRequest(newContact);
    expect(controller.sentRequests.length, 4);
    verify(mockRequestServiceImpl.sendRequest(any)).called(1);
  });

  test('Set text filter', () async {
    await controller.updateRequests();
    controller.setTextFilter("4");
    expect(controller.filteredPendingRequests.length, 1);
    expect(controller.filteredPendingRequests[0].id, "4");
  });
}
