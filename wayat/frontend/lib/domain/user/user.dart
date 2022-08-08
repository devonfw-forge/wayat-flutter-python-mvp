import 'dart:convert';

class User {
  String name;
  String email;
  String imageUrl;
  String phone;

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phone,
  });

  User copyWith({
    String? name,
    String? email,
    String? imageUrl,
    String? phone,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(name: $name, email: $email, imageUrl: $imageUrl, phone: $phone)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.imageUrl == imageUrl &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        phone.hashCode;
  }
}
