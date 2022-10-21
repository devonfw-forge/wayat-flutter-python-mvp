import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'contacts_page_controller_test.mocks.dart';

@GenerateMocks([RequestsController, FriendsController, SuggestionsController])
void main() async {
  MockRequestsController mockRequestsController = MockRequestsController();
  MockFriendsController mockFriendsController = MockFriendsController();
  MockSuggestionsController mockSuggestionsController =
      MockSuggestionsController();

  ContactsPageController controller = ContactsPageController(
      friendsController: mockFriendsController,
      requestsController: mockRequestsController,
      suggestionsController: mockSuggestionsController);

  when(mockSuggestionsController.setTextFilter(any)).thenReturn(null);
  when(mockRequestsController.setTextFilter(any)).thenReturn(null);
  when(mockFriendsController.setTextFilter(any)).thenReturn(null);
  when(mockFriendsController.updateContacts()).thenAnswer(Future.value);
  when(mockRequestsController.updateRequests()).thenAnswer(Future.value);
  when(mockSuggestionsController.updateSuggestedContacts())
      .thenAnswer(Future.value);
  setUpAll(() async {});

  test('Check set SearchbarText sets text filter in subcontrollers', () async {
    controller.setSearchBarText("test");
    verify(mockFriendsController.setTextFilter(any)).called(1);
    verify(mockSuggestionsController.setTextFilter(any)).called(1);
    verify(mockRequestsController.setTextFilter(any)).called(1);
  });

  test("Check that data is retrieve in a time interval", () async {
    controller.updateTabData(0);
    controller.updateTabData(0);
    //The second will be omitted by the controller
    verify(mockFriendsController.updateContacts()).called(1);
    controller.updateTabData(1);
    controller.updateTabData(1);
    //The second will be omitted by the controller
    verify(mockRequestsController.updateRequests()).called(1);
    controller.updateTabData(2);
    controller.updateTabData(2);
    //The second will be omitted by the controller
    verify(mockSuggestionsController.updateSuggestedContacts()).called(1);
  });
}
