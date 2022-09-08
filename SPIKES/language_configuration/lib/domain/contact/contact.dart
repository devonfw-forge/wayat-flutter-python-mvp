import 'dart:convert';
import 'package:wayat/domain/user/user.dart';

class Contact extends User {
  bool available;

  Contact({
    required this.available,
    required super.id,
    required super.name,
    required super.email,
    required super.imageUrl,
    required super.phone,
  });

  @override
  Contact copyWith({
    bool? available,
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? phone,
  }) {
    return Contact(
      available: available ?? this.available,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['available'] = available;
    return map;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as String,
      available: map['available'] ?? false,
      name: map['name'] as String,
      email: map['email'] ?? "",
      imageUrl: map['image_url'] as String,
      phone: map['phone'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(id: $id, available: $available, name: $name, email: $email, imageUrl: $imageUrl, phone: $phone)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return available.hashCode ^ super.hashCode;
  }
}
