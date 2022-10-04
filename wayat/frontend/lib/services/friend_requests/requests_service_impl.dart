import 'package:get_it/get_it.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/friend_requests/models/friend_request_response.dart';
import 'package:wayat/services/friend_requests/requests_service.dart';

/// Implementation of the RequestsService.
class RequestsServiceImpl implements RequestsService {
  /// Manages the http connections with the server.
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  @override
  Future<FriendRequestRespone> getRequests() async {
    Map<String, dynamic> friendRequests =
        await httpProvider.sendGetRequest(APIContract.friendRequests);

    return FriendRequestRespone.fromMap(friendRequests);
  }

  @override
  Future<bool> sendRequests(List<Contact> contacts) async {
    return (await httpProvider.sendPostRequest(APIContract.addContact,
                    {"users": contacts.map((e) => e.id).toList()}))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> acceptRequest(Contact contact) async {
    return (await httpProvider.sendPostRequest(APIContract.friendRequests,
                    {"uid": contact.id, "accept": true}))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> rejectRequest(Contact contact) async {
    return (await httpProvider.sendPostRequest(APIContract.friendRequests,
                    {"uid": contact.id, "accept": false}))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> sendRequest(Contact contact) async {
    return (await httpProvider.sendPostRequest(APIContract.addContact, {
              "users": [contact.id]
            }))
                .statusCode /
            10 ==
        20;
  }

  @override
  Future<bool> cancelRequest(Contact contact) async {
    return await httpProvider
        .sendDelRequest("${APIContract.sentFriendRequests}/${contact.id}");
  }
}
