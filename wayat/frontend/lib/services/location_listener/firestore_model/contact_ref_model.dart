// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents the additional data provided in firestore to locate a contact
/// from the user.
///
/// It is used to map the data provided from Firestore and then create a
/// [ContactLocation] by joining the data present in this model with
/// the [Contact] list of the user
class ContactRefModel {
  /// The user id. Uses this name instead of just `id` to be more exact with the
  /// representation in Firestore.
  final String uid;

  /// Current coordinates of the contact in the Firestore format.
  final GeoPoint location;

  /// Current address of the contact.
  ///
  /// Can be the address, `null` or the error code `ERROR_ADDRESS`.
  final String? address;

  /// When this location information was last updated.
  final Timestamp lastUpdated;

  ContactRefModel({
    required this.uid,
    required this.location,
    required this.address,
    required this.lastUpdated,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'location': location,
      'address': address,
      'lastUpdated': lastUpdated,
    };
  }

  factory ContactRefModel.fromMap(Map<String, dynamic> map) {
    return ContactRefModel(
      uid: map['uid'] as String,
      location: map['location'] as GeoPoint,
      address: map['address'] as String,
      lastUpdated: map['last_updated'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactRefModel.fromJson(String source) =>
      ContactRefModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ContactRefModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.location == location &&
        other.address == address &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        location.hashCode ^
        address.hashCode ^
        lastUpdated.hashCode;
  }
}
