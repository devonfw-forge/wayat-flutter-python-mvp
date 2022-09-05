import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/api_contract/api_contract.dart';
import 'package:wayat/services/friend_requests/requests_service.dart';

class RequestsServiceImpl extends RequestsService {
  @override
  Future<Map<String, List<Contact>>> getRequests() async {
    Map<String, dynamic> friendRequests =
        await super.sendGetRequest(APIContract.friendRequests);

    List<Contact> pendingRequests =
        (friendRequests["pending_requests"] as List).map((e) {
      return Contact.fromMap(e);
    }).toList();

    List<Contact> sentRequests =
        (friendRequests["sent_requests"] as List).map((e) {
      return Contact.fromMap(e);
    }).toList();

    return {"pending_requests": pendingRequests, "sent_requests": sentRequests};
  }

  @override
  Future<bool> sendRequests(List<Contact> contacts) async {
    return (await super.sendPostRequest(APIContract.addContact,
                    {"users": contacts.map((e) => e.id).toList()}))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> acceptRequest(Contact contact) async {
    return (await super.sendPostRequest(APIContract.friendRequests,
                    {"uid": contact.id, "accept": true}))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> rejectRequest(Contact contact) async {
    return (await super.sendPostRequest(APIContract.friendRequests,
                    {"uid": contact.id, "accept": false}))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> sendRequest(Contact contact) async {
    return (await super.sendPostRequest(APIContract.addContact, {
              "users": [contact.id]
            }))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> unsendRequest(Contact contact) async {
    return await super
        .sendDelRequest("${APIContract.sentFriendRequests}/${contact.id}");
  }
}
