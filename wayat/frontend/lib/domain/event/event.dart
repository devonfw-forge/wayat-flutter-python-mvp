// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Event {
  final int id;
  final String photoUrl;
  final String description;
  final String name;
  final String location;
  final String startDate;
  final String endDate;
  final String startHour;
  final String endHour;
  final String createdBy;
  final int userId;

  Event({
    required this.id,
    required this.photoUrl,
    required this.description,
    required this.name,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.startHour,
    required this.endHour,
    required this.createdBy,
    required this.userId,
  });

  Event copyWith({
    int? id,
    String? photoUrl,
    String? description,
    String? name,
    String? location,
    String? startDate,
    String? endDate,
    String? startHour,
    String? endHour,
    String? createdBy,
    int? userId,
  }) {
    return Event(
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      description: description ?? this.description,
      name: name ?? this.name,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startHour: startHour ?? this.startHour,
      endHour: endHour ?? this.endHour,
      createdBy: createdBy ?? this.createdBy,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idEvent': id,
      'photoUrl': photoUrl,
      'description': description,
      'eventName': name,
      'eventLocation': location,
      'eventStartDate': startDate,
      'eventEndDate': endDate,
      'eventStartHour': startHour,
      'eventEndHour': endHour,
      'createdBy': createdBy,
      'idUser': userId,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['idEvent'] as int,
      photoUrl: map['photoUrl'] as String,
      description: map['description'] as String,
      name: map['eventName'] as String,
      location: map['eventLocation'] as String,
      startDate: map['eventStartDate'] as String,
      endDate: map['eventEndDate'] as String,
      startHour: map['eventStartHour'] as String,
      endHour: map['eventEndHour'] as String,
      createdBy: map['createdBy'] as String,
      userId: map['idUser'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(idEvent: $id, photoUrl: $photoUrl, description: $description, eventName: $name, eventLocation: $location, eventStartDate: $startDate, eventEndDate: $endDate, eventStartHour: $startHour, eventEndHour: $endHour, createdBy: $createdBy, idUser: $userId)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.photoUrl == photoUrl &&
        other.description == description &&
        other.name == name &&
        other.location == location &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.startHour == startHour &&
        other.endHour == endHour &&
        other.createdBy == createdBy &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        photoUrl.hashCode ^
        description.hashCode ^
        name.hashCode ^
        location.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        startHour.hashCode ^
        endHour.hashCode ^
        createdBy.hashCode ^
        userId.hashCode;
  }
}
