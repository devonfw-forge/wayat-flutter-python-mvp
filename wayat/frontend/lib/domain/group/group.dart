// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:wayat/domain/contact/contact.dart';

/// Entity of Group
class Group {
  /// unique id of group
  String id;

  /// Members added to this group
  List<Contact> members;

  /// Name assign by the user
  String name;

  /// Image set by the user
  String imageUrl;

  Group({
    required this.id,
    required this.members,
    required this.name,
    required this.imageUrl,
  });

  Group copyWith({
    String? id,
    List<Contact>? members,
    String? name,
    String? imageUrl,
  }) {
    return Group(
      id: id ?? this.id,
      members: members ?? this.members,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory Group.empty() {
    return Group(id: "", members: [], name: "", imageUrl: "");
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'members': members.map((x) => x.toMap()).toList(),
      'name': name,
      'image_url': imageUrl,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as String,
      members: List<Contact>.from(
        (map['members']).map<Contact>(
          (x) => Contact.fromMap(x as Map<String, dynamic>),
        ),
      ),
      name: map['name'] as String,
      imageUrl: map['image_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) =>
      Group.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Group(id: $id, members: $members, name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant Group other) {
    if (identical(this, other)) return true;

    return listEquals(other.members, members) &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode =>
      id.hashCode ^ members.hashCode ^ name.hashCode ^ imageUrl.hashCode;
}
