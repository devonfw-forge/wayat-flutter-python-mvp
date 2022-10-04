// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRefModel {
  final String uid;
  final GeoPoint location;
  final String? address;
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
