import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/friend_requests/requests_service.dart';
import 'package:wayat/services/friend_requests/requests_service_impl.dart';

part 'requests_controller.g.dart';

// ignore: library_private_types_in_public_api
class RequestsController = _RequestsController with _$RequestsController;

abstract class _RequestsController with Store {
  final RequestsService _service = RequestsServiceImpl();
  static const String pendingRequestsKey = "pending_requests";
  static const String sentRequestsKey = "sent_requests";

  String textFilter = "";

  @observable
  ObservableMap<String, List<Contact>> requests =
      ObservableMap.of({pendingRequestsKey: [], sentRequestsKey: []});

  @observable
  ObservableList<Contact> filteredPendingRequests = ObservableList.of([]);

  @computed
  List<Contact> get pendingRequests => requests[pendingRequestsKey]!;

  @computed
  List<Contact> get sentRequests => requests[sentRequestsKey]!;

  @action
  Future updateRequests() async {
    requests = ObservableMap.of(await _service.getRequests());
    filteredPendingRequests = ObservableList.of(pendingRequests
        .where((element) =>
            element.name.toLowerCase().contains(textFilter.toLowerCase()))
        .toList());
  }

  @action
  void sendRequest(Contact contact) {
    //TODO: UNCOMMENT THIS CODE WHEN REJECT IS IMPLEMENTED
/*     pendingRequests.remove(contact);
    _service.rejectRequest(contact); */
  }

  @action
  void rejectRequest(Contact contact) {
    //TODO: UNCOMMENT THIS CODE WHEN REJECT IS IMPLEMENTED
/*     pendingRequests.remove(contact);
    _service.rejectRequest(contact); */
  }

  @action
  void acceptRequest(Contact contact) {
    //TODO: UNCOMMENT THIS CODE WHEN REJECT IS IMPLEMENTED
/*     pendingRequests.remove(contact);
    _service.acceptRequest(contact); */
  }

  @action
  void unsendRequest(Contact contact) {
    //TODO: UNCOMMENT THIS CODE WHEN REJECT IS IMPLEMENTED
/*     sentRequests.remove(contact);
    _service.unsendRequest(contact); */
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
