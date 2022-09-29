import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/services/friend_requests/requests_service.dart';
import 'package:wayat/services/friend_requests/requests_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

part 'requests_controller.g.dart';

/// Controller containing business logic for Request tab inside contacts page
// ignore: library_private_types_in_public_api
class RequestsController = _RequestsController with _$RequestsController;

/// Base Controller for Request tab using MobX
abstract class _RequestsController with Store {
  /// Service providing request information of current user.
  final RequestsService _service;

  /// Key to access pending Request in request response
  static const String pendingRequestsKey = "pending_requests";

  /// Key to access sent Request in request response
  static const String sentRequestsKey = "sent_requests";

  /// Friends controller to update the list of friends
  final FriendsController friendsController;

  _RequestsController(
      {required this.friendsController, RequestsService? requestsService})
      : _service = requestsService ?? RequestsServiceImpl();

  /// Text filter containing query of a searchbar to filter contacts
  String textFilter = "";

  /// List of filtered pending requests by [textFilter]
  @observable
  ObservableList<Contact> filteredPendingRequests = ObservableList.of([]);

  /// List of pending requests
  @observable
  ObservableList<Contact> pendingRequests = ObservableList.of([]);

  /// List of sent requests
  @observable
  ObservableList<Contact> sentRequests = ObservableList.of([]);

  /// Update request from backend
  @action
  Future<void> updateRequests() async {
    Map<String, List<Contact>> requests = await _service.getRequests();

    if (ListUtilsService.haveDifferentElements(
        pendingRequests, requests[pendingRequestsKey]!)) {
      pendingRequests = ObservableList.of(requests[pendingRequestsKey]!);
      filteredPendingRequests = ObservableList.of(pendingRequests
          .where((element) =>
              element.name.toLowerCase().contains(textFilter.toLowerCase()))
          .toList());
    }
    if (ListUtilsService.haveDifferentElements(
        sentRequests, requests[sentRequestsKey]!)) {
      sentRequests = ObservableList.of(requests[sentRequestsKey]!);
    }
  }

  /// Sends friend request to a contact
  @action
  Future<void> sendRequest(Contact contact) async {
    sentRequests.add(contact);
    _service.sendRequest(contact);
  }

  /// Reject friend request of a contact
  @action
  Future<void> rejectRequest(Contact contact) async {
    pendingRequests.remove(contact);
    filteredPendingRequests.remove(contact);
    _service.rejectRequest(contact);
  }

  /// Accept request friend of a contact
  @action
  Future<void> acceptRequest(Contact contact) async {
    pendingRequests.remove(contact);
    filteredPendingRequests.remove(contact);
    if (await _service.acceptRequest(contact)) {
      friendsController.updateContacts();
    }
  }

  /// Cancel a sent request to a contact
  @action
  Future<void> unsendRequest(Contact contact) async {
    sentRequests.remove(contact);
    _service.unsendRequest(contact);
  }

  /// Change [textFilter] to update the query of filter contacts
  @action
  void setTextFilter(String text) {
    textFilter = text;
    filteredPendingRequests = ObservableList.of(pendingRequests
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }
}
