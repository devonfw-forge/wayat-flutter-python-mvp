import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/friend_requests/models/friend_request_response.dart';

void main() async {
  test('copyWith is correct', () {
    FriendRequestResponse response = defaultResponse();
    FriendRequestResponse fullCopy = response.copyWith();
    expect(response, fullCopy);
    FriendRequestResponse partialCopy = response.copyWith(sentRequests: []);
    expect(partialCopy != response, true);
  });

  test('toMap is correct', () {
    FriendRequestResponse response = defaultResponse();

    Map<String, dynamic> mapResponse = {
      'sent_requests': [generateContact('id').toMap()],
      'pending_requests': [generateContact('id2').toMap()]
    };

    expect(response.toMap(), mapResponse);
  });

  test('fromMap is correct', () {
    FriendRequestResponse response = defaultResponse();

    Map<String, dynamic> mapResponse = {
      'sent_requests': [generateContact('id').toMap()],
      'pending_requests': [generateContact('id2').toMap()]
    };

    expect(response, FriendRequestResponse.fromMap(mapResponse));
  });

  test('toJson is correct', () {
    Map<String, dynamic> mapResponse = {
      'sent_requests': [generateContact('id').toMap()],
      'pending_requests': [generateContact('id2').toMap()]
    };

    expect(jsonEncode(mapResponse), defaultResponse().toJson());
  });

  test('fromJson is correct', () {
    Map<String, dynamic> mapResponse = {
      'sent_requests': [generateContact('id').toMap()],
      'pending_requests': [generateContact('id2').toMap()]
    };

    expect(FriendRequestResponse.fromJson(jsonEncode(mapResponse)),
        defaultResponse());
  });

  test('toString is correct', () {
    FriendRequestResponse response = defaultResponse();
    expect(
        response.toString(),
        'FriendRequestRespone(sentRequests: ${response.sentRequests},'
        ' receivedRequests: ${response.receivedRequests})');
  });

  test('Operator == is correct', () {
    FriendRequestResponse response = defaultResponse();
    FriendRequestResponse fullCopy = response.copyWith();
    expect(response == fullCopy, true);
    FriendRequestResponse partialCopy = response.copyWith(sentRequests: []);
    expect(partialCopy != response, true);
  });

  test('hashCode is correct', () {
    FriendRequestResponse response = defaultResponse();
    FriendRequestResponse fullCopy = response.copyWith();
    expect(response.hashCode, fullCopy.hashCode);
    FriendRequestResponse partialCopy = response.copyWith(sentRequests: []);
    expect(partialCopy.hashCode != response.hashCode, true);
  });
}

FriendRequestResponse defaultResponse() {
  return FriendRequestResponse(
      sentRequests: [generateContact('id')],
      receivedRequests: [generateContact('id2')]);
}

Contact generateContact(String id) {
  return Contact(
      shareLocationTo: true,
      id: id,
      name: 'name',
      email: 'email',
      imageUrl: 'imageUrl',
      phone: 'phone');
}
