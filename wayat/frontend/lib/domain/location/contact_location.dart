import 'package:wayat/domain/contact/contact.dart';

class ContactLocation extends Contact {
  double latitude;
  double longitude;
  DateTime lastUpdated;

  int get hashCode =>
      latitude.hashCode ^ longitude.hashCode ^ lastUpdated.hashCode;

  ContactLocation(
      {required super.available,
      required super.displayName,
      required super.username,
      required super.email,
      required super.imageUrl,
      required this.latitude,
      required this.longitude,
      required this.lastUpdated});

  @override
  ContactLocation copyWith(
      {bool? available,
      String? displayName,
      String? username,
      String? email,
      String? imageUrl,
      double? latitude,
      double? longitude,
      DateTime? lastUpdated}) {
    return ContactLocation(
        available: available ?? this.available,
        displayName: displayName ?? this.displayName,
        username: username ?? this.username,
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        lastUpdated: lastUpdated ?? this.lastUpdated);
  }

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'lastUpdated': lastUpdated
    };
  }

  factory ContactLocation.fromMap(Map<String, dynamic> map) {
    return ContactLocation(
        available: map['available'] as bool,
        displayName: map['displayName'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
        imageUrl: map['imageUrl'] as String,
        latitude: map['latitude'] as double,
        longitude: map['longitude'] as double,
        lastUpdated: map['lastUpdated'] as DateTime);
  }
}
