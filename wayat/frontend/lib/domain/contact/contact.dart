import 'dart:convert';
import 'package:wayat/domain/user/user.dart';

/// Class [Contact] which inherits from User
class Contact extends User {

  /// Whether contact is sharing own location
  bool shareLocationTo;

  /// Contact entity constructor
  Contact({
    required this.shareLocationTo,
    required super.id,
    required super.name,
    required super.email,
    required super.imageUrl,
    required super.phone,
  });

  @override
  Contact copyWith({
    bool? shareLocationTo,
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? phone,
  }) {
    return Contact(
      shareLocationTo: shareLocationTo ?? this.shareLocationTo,
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
    map['share_location'] = shareLocationTo;
    return map;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] ?? "",
        imageUrl: map['image_url'] as String,
        phone: map['phone'] as String,
        shareLocationTo: (map['share_location'] ?? false) as bool);
  }

  @override
  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, email: $email, imageUrl: $imageUrl, phone: $phone, shareLocation: $shareLocationTo)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return shareLocationTo.hashCode ^ super.hashCode;
  }
}
