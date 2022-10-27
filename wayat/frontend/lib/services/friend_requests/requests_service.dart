import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/friend_requests/models/friend_request_response.dart';

/// Manages the communication with the server related with friend requests.
abstract class RequestsService {
  /// Returns a [Map] with all of the request of the current user.
  ///
  /// The Map will have two Lists of [Contact], one for sent requests with the
  /// key `sent_requests`, and the received requests with `pending_requests`.
  Future<FriendRequestResponse> getRequests();

  /// Accepts the received request from [contact].
  Future<bool> acceptRequest(Contact contact);

  /// Rejects the received request from [contact].
  Future<bool> rejectRequest(Contact contact);

  /// Sends a friend request to [contact].
  Future<bool> sendRequest(Contact contact);

  /// Sends a request to each member of [contacts].
  Future<bool> sendRequests(List<Contact> contacts);

  /// Cancels a previously sent request to [contact].
  Future<bool> cancelRequest(Contact contact);
}
