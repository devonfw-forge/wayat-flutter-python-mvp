// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wayat/domain/contact/contact.dart';

/// Contains list of sent and received Friends request
class FriendRequestResponse {
  /// List of contacts that user has sent friend request
  List<Contact> sentRequests;

  /// List of contacts that have sent friend request to the user
  List<Contact> receivedRequests;

  FriendRequestResponse({
    required this.sentRequests,
    required this.receivedRequests,
  });

  FriendRequestResponse copyWith({
    List<Contact>? sentRequests,
    List<Contact>? receivedRequests,
  }) {
    return FriendRequestResponse(
      sentRequests: sentRequests ?? this.sentRequests,
      receivedRequests: receivedRequests ?? this.receivedRequests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sent_requests': sentRequests.map((x) => x.toMap()).toList(),
      'pending_requests': receivedRequests.map((x) => x.toMap()).toList(),
    };
  }

  factory FriendRequestResponse.fromMap(Map<String, dynamic> map) {
    return FriendRequestResponse(
      sentRequests: List<Contact>.from(
        (map['sent_requests'] as List<dynamic>).map<Contact>(
          (x) => Contact.fromMap(x as Map<String, dynamic>),
        ),
      ),
      receivedRequests: List<Contact>.from(
        (map['pending_requests'] as List<dynamic>).map<Contact>(
          (x) => Contact.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendRequestResponse.fromJson(String source) =>
      FriendRequestResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FriendRequestRespone(sentRequests: $sentRequests, receivedRequests: $receivedRequests)';

  @override
  bool operator ==(covariant FriendRequestResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.sentRequests, sentRequests) &&
        listEquals(other.receivedRequests, receivedRequests);
  }

  @override
  int get hashCode => sentRequests.hashCode ^ receivedRequests.hashCode;
}
