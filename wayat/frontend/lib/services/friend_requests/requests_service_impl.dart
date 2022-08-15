import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';
import 'package:wayat/services/friend_requests/requests_service.dart';

class RequestsServiceImpl extends RequestsService {
  Future<Map<String, List<Contact>>> getRequests() async {
    // TODO: IMPLEMENT GET REQUESTS

    return {
      "pending_requests": ContactsMock.availableContacts(),
      "sent_requests": ContactsMock.unavailableContacts()
    };
  }

  @override
  Future sendRequests(List<Contact> contacts) async {
    await super.sendPostRequest(
        "users/add-contact", {"users": contacts.map((e) => e.id).toList()});
  }

  @override
  Future acceptRequest(Contact contact) async {
    // TODO: implement acceptRequest
  }

  @override
  Future rejectRequest(Contact contact) async {
    // TODO: implement rejectRequest
  }

  @override
  Future sendRequest(Contact contact) async {
    // TODO: implement sendRequest
  }

  @override
  Future unsendRequest(Contact contact) async {
    // TODO: implement sendRequest
  }
}
