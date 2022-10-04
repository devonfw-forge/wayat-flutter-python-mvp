// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:wayat/domain/contact/contact.dart';

/// Contains list of sent and received Friends request
class FriendRequestRespone {
  /// List of contacts that user has sent friend request
  List<Contact> sentRequests;

  /// List of contacts that have sent friend request to the user
  List<Contact> receivedRequests;
  FriendRequestRespone({
    required this.sentRequests,
    required this.receivedRequests,
  });

  FriendRequestRespone copyWith({
    List<Contact>? sentRequests,
    List<Contact>? receivedRequests,
  }) {
    return FriendRequestRespone(
      sentRequests: sentRequests ?? this.sentRequests,
      receivedRequests: receivedRequests ?? this.receivedRequests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sentRequests': sentRequests.map((x) => x.toMap()).toList(),
      'receivedRequests': receivedRequests.map((x) => x.toMap()).toList(),
    };
  }

  factory FriendRequestRespone.fromMap(Map<String, dynamic> map) {
    return FriendRequestRespone(
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

  factory FriendRequestRespone.fromJson(String source) =>
      FriendRequestRespone.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FriendRequestRespone(sentRequests: $sentRequests, receivedRequests: $receivedRequests)';

  @override
  bool operator ==(covariant FriendRequestRespone other) {
    if (identical(this, other)) return true;

    return listEquals(other.sentRequests, sentRequests) &&
        listEquals(other.receivedRequests, receivedRequests);
  }

  @override
  int get hashCode => sentRequests.hashCode ^ receivedRequests.hashCode;
}
