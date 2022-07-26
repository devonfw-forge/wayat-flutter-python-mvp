import 'dart:convert';

class Contact {
  bool available;
  String displayName;
  String username;
  String email;
  String imageUrl;

  Contact({
    required this.available,
    required this.displayName,
    required this.username,
    required this.email,
    required this.imageUrl,
  });

  Contact copyWith({
    bool? available,
    String? displayName,
    String? username,
    String? email,
    String? imageUrl,
  }) {
    return Contact(
      available: available ?? this.available,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'available': available,
      'displayName': displayName,
      'username': username,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      available: map['available'] as bool,
      displayName: map['displayName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contact(available: $available, displayName: $displayName, username: $username, email: $email, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant Contact other) {
    if (identical(this, other)) return true;

    return other.available == available &&
        other.displayName == displayName &&
        other.username == username &&
        other.email == email &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return available.hashCode ^
        displayName.hashCode ^
        username.hashCode ^
        email.hashCode ^
        imageUrl.hashCode;
  }
}
