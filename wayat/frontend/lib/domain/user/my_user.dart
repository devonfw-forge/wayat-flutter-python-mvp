import 'dart:convert';

import 'package:wayat/domain/user/user.dart';

class MyUser extends User {
  bool onboardingCompleted;

  MyUser({
    required super.id, 
    required super.name, 
    required super.email, 
    required super.imageUrl, 
    required super.phone,
    required this.onboardingCompleted,
  });
  
  @override
  MyUser copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    String? phone,
    bool? onboardingCompleted
  }) {
    return MyUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
      onboardingCompleted: 
        onboardingCompleted ?? this.onboardingCompleted,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'image_url': imageUrl,
      'phone': phone,
      'onboardingCompleted': onboardingCompleted
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      imageUrl: map['image_url'] as String,
      phone: map['phone'] ?? "",
      onboardingCompleted: map['onboarding_completed'] as bool
    );
  }


  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;
    return super == other &&
        other.onboardingCompleted == onboardingCompleted;
  }

  @override
  int get hashCode {
    return super.hashCode ^
        onboardingCompleted.hashCode;
  }
}