import 'package:wayat/domain/contact/contact.dart';
import 'dart:convert';

class ContactLocation extends Contact {
  double latitude;
  double longitude;
  String address;
  DateTime lastUpdated;

  @override
  int get hashCode =>
      super.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      address.hashCode ^
      lastUpdated.hashCode;

  ContactLocation(
      {required super.available,
      required super.id,
      required super.name,
      required super.email,
      required super.imageUrl,
      required super.phone,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.lastUpdated});

  @override
  ContactLocation copyWith(
      {bool? available,
      String? id,
      String? name,
      String? email,
      String? imageUrl,
      String? phone,
      double? latitude,
      double? longitude,
      String? address,
      DateTime? lastUpdated}) {
    return ContactLocation(
        available: available ?? this.available,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        phone: phone ?? this.phone,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address ?? this.address,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'lastUpdated': lastUpdated
    };
  }

  factory ContactLocation.fromMap(Map<String, dynamic> map) {
    return ContactLocation(
        available: map['available'] as bool,
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        imageUrl: map['image_url'] as String,
        phone: map['phone'] as String,
        latitude: map['latitude'] as double,
        longitude: map['longitude'] as double,
        address: (map['address'] ?? "") as String,
        lastUpdated: map['lastUpdated'] as DateTime);
  }

  @override
  bool operator ==(covariant ContactLocation other) {
    return latitude == other.latitude &&
        longitude == other.longitude &&
        lastUpdated == other.lastUpdated &&
        super == other;
  }
}
