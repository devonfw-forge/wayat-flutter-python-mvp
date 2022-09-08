// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/lang/app_localizations.dart';

class Group {
  String id;
  List<Contact> contacts;
  String name;
  String imageUrl;

  Group({
    required this.id,
    required this.contacts,
    required this.name,
    required this.imageUrl,
  });

  Group copyWith({
    String? id,
    List<Contact>? contacts,
    String? name,
    String? imageUrl,
  }) {
    return Group(
      id: id ?? this.id,
      contacts: contacts ?? this.contacts,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory Group.empty() {
    return Group(id: "", contacts: [], name: "", imageUrl: "");
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'contacts': contacts.map((x) => x.toMap()).toList(),
      'name': name,
      'image_url': imageUrl,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as String,
      contacts: List<Contact>.from(
        (map['contacts']).map<Contact>(
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
      'Group(id: $id, contacts: $contacts, name: $name, imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant Group other) {
    if (identical(this, other)) return true;

    return listEquals(other.contacts, contacts) &&
        other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode =>
      id.hashCode ^ contacts.hashCode ^ name.hashCode ^ imageUrl.hashCode;
}
