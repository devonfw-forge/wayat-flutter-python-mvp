import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/services/friend_requests/requests_service.dart';
import 'package:wayat/services/friend_requests/requests_service_impl.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

part 'requests_controller.g.dart';

// ignore: library_private_types_in_public_api
class RequestsController = _RequestsController with _$RequestsController;

abstract class _RequestsController with Store {
  final RequestsService _service;
  static const String pendingRequestsKey = "pending_requests";
  static const String sentRequestsKey = "sent_requests";
  final FriendsController friendsController;

  _RequestsController(
      {required this.friendsController, RequestsService? requestsService})
      : _service = requestsService ?? RequestsServiceImpl();

  String textFilter = "";

  @observable
  ObservableList<Contact> filteredPendingRequests = ObservableList.of([]);

  @observable
  ObservableList<Contact> pendingRequests = ObservableList.of([]);

  @observable
  ObservableList<Contact> sentRequests = ObservableList.of([]);

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

  @action
  Future<void> sendRequest(Contact contact) async {
    sentRequests.add(contact);
    _service.sendRequest(contact);
  }

  @action
  Future<void> rejectRequest(Contact contact) async {
    pendingRequests.remove(contact);
    filteredPendingRequests.remove(contact);
    _service.rejectRequest(contact);
  }

  @action
  Future<void> acceptRequest(Contact contact) async {
    pendingRequests.remove(contact);
    filteredPendingRequests.remove(contact);
    if (await _service.acceptRequest(contact)) {
      friendsController.updateContacts();
    }
  }

  @action
  Future<void> unsendRequest(Contact contact) async {
    sentRequests.remove(contact);
    _service.unsendRequest(contact);
  }

  @action
  void setTextFilter(String text) {
    textFilter = text;
    filteredPendingRequests = ObservableList.of(pendingRequests
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }
}
