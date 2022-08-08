import 'package:wayat/domain/contact/contact.dart';

class ContactLocation extends Contact {
  double latitude;
  double longitude;
  DateTime lastUpdated;

  @override
  int get hashCode =>
      super.hashCode ^ latitude.hashCode ^ longitude.hashCode ^ lastUpdated.hashCode;

  ContactLocation(
      {required super.available,
      required super.name,
      required super.email,
      required super.imageUrl,
      required super.phone,
      required this.latitude,
      required this.longitude,
      required this.lastUpdated});

  @override
  ContactLocation copyWith({
    bool? available,
    String? name,
    String? email,
    String? imageUrl,
    String? phone,
    double? latitude,
    double? longitude,
    DateTime? lastUpdated
  }) {
    return ContactLocation(
      available: available ?? this.available,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      lastUpdated: lastUpdated ?? this.lastUpdated
    );
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
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      phone: map['phone'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      lastUpdated: map['lastUpdated'] as DateTime
    );
  }
}
