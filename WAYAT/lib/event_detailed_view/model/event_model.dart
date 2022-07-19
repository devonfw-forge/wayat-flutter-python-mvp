// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventModel {
  
    final int idEvent;
    final String photoUrl;
    final String description;
    final String eventName;
    final String eventLocation;
    final String eventStartDate;
    final String eventEndDate;
    final String eventStartHour;
    final String eventEndHour;
    final String createdBy;
    final int idUser;

  EventModel({
    required this.idEvent,
    required this.photoUrl,
    required this.description,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventStartHour,
    required this.eventEndHour,
    required this.createdBy,
    required this.idUser,
  });

  EventModel copyWith({
    int? idEvent,
    String? photoUrl,
    String? description,
    String? eventName,
    String? eventLocation,
    String? eventStartDate,
    String? eventEndDate,
    String? eventStartHour,
    String? eventEndHour,
    String? createdBy,
    int? idUser,
  }) {
    return EventModel(
      idEvent: idEvent ?? this.idEvent,
      photoUrl: photoUrl ?? this.photoUrl,
      description: description ?? this.description,
      eventName: eventName ?? this.eventName,
      eventLocation: eventLocation ?? this.eventLocation,
      eventStartDate: eventStartDate ?? this.eventStartDate,
      eventEndDate: eventEndDate ?? this.eventEndDate,
      eventStartHour: eventStartHour ?? this.eventStartHour,
      eventEndHour: eventEndHour ?? this.eventEndHour,
      createdBy: createdBy ?? this.createdBy,
      idUser: idUser ?? this.idUser,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idEvent': idEvent,
      'photoUrl': photoUrl,
      'description': description,
      'eventName': eventName,
      'eventLocation': eventLocation,
      'eventStartDate': eventStartDate,
      'eventEndDate': eventEndDate,
      'eventStartHour': eventStartHour,
      'eventEndHour': eventEndHour,
      'createdBy': createdBy,
      'idUser': idUser,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      idEvent: map['idEvent'] as int,
      photoUrl: map['photoUrl'] as String,
      description: map['description'] as String,
      eventName: map['eventName'] as String,
      eventLocation: map['eventLocation'] as String,
      eventStartDate: map['eventStartDate'] as String,
      eventEndDate: map['eventEndDate'] as String,
      eventStartHour: map['eventStartHour'] as String,
      eventEndHour: map['eventEndHour'] as String,
      createdBy: map['createdBy'] as String,
      idUser: map['idUser'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) => EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventModel(idEvent: $idEvent, photoUrl: $photoUrl, description: $description, eventName: $eventName, eventLocation: $eventLocation, eventStartDate: $eventStartDate, eventEndDate: $eventEndDate, eventStartHour: $eventStartHour, eventEndHour: $eventEndHour, createdBy: $createdBy, idUser: $idUser)';
  }

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.idEvent == idEvent &&
      other.photoUrl == photoUrl &&
      other.description == description &&
      other.eventName == eventName &&
      other.eventLocation == eventLocation &&
      other.eventStartDate == eventStartDate &&
      other.eventEndDate == eventEndDate &&
      other.eventStartHour == eventStartHour &&
      other.eventEndHour == eventEndHour &&
      other.createdBy == createdBy &&
      other.idUser == idUser;
  }

  @override
  int get hashCode {
    return idEvent.hashCode ^
      photoUrl.hashCode ^
      description.hashCode ^
      eventName.hashCode ^
      eventLocation.hashCode ^
      eventStartDate.hashCode ^
      eventEndDate.hashCode ^
      eventStartHour.hashCode ^
      eventEndHour.hashCode ^
      createdBy.hashCode ^
      idUser.hashCode;
  }
}
