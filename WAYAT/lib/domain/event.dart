// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventModel {
  
    final int eventID;
    final String eventPhotoUrl;
    final String eventDescription;
    final String eventName;
    final String eventLocation;
    final String eventStartDate;
    final String eventEndDate;
    final String eventStartHour;
    final String eventEndHour;
    final String eventCreatedBy;
    final int eventUserID;

  EventModel({
    required this.eventID,
    required this.eventPhotoUrl,
    required this.eventDescription,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventStartHour,
    required this.eventEndHour,
    required this.eventCreatedBy,
    required this.eventUserID,
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
      eventID: idEvent ?? this.eventID,
      eventPhotoUrl: photoUrl ?? this.eventPhotoUrl,
      eventDescription: description ?? this.eventDescription,
      eventName: eventName ?? this.eventName,
      eventLocation: eventLocation ?? this.eventLocation,
      eventStartDate: eventStartDate ?? this.eventStartDate,
      eventEndDate: eventEndDate ?? this.eventEndDate,
      eventStartHour: eventStartHour ?? this.eventStartHour,
      eventEndHour: eventEndHour ?? this.eventEndHour,
      eventCreatedBy: createdBy ?? this.eventCreatedBy,
      eventUserID: idUser ?? this.eventUserID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idEvent': eventID,
      'photoUrl': eventPhotoUrl,
      'description': eventDescription,
      'eventName': eventName,
      'eventLocation': eventLocation,
      'eventStartDate': eventStartDate,
      'eventEndDate': eventEndDate,
      'eventStartHour': eventStartHour,
      'eventEndHour': eventEndHour,
      'createdBy': eventCreatedBy,
      'idUser': eventUserID,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventID: map['idEvent'] as int,
      eventPhotoUrl: map['photoUrl'] as String,
      eventDescription: map['description'] as String,
      eventName: map['eventName'] as String,
      eventLocation: map['eventLocation'] as String,
      eventStartDate: map['eventStartDate'] as String,
      eventEndDate: map['eventEndDate'] as String,
      eventStartHour: map['eventStartHour'] as String,
      eventEndHour: map['eventEndHour'] as String,
      eventCreatedBy: map['createdBy'] as String,
      eventUserID: map['idUser'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) => EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventModel(idEvent: $eventID, photoUrl: $eventPhotoUrl, description: $eventDescription, eventName: $eventName, eventLocation: $eventLocation, eventStartDate: $eventStartDate, eventEndDate: $eventEndDate, eventStartHour: $eventStartHour, eventEndHour: $eventEndHour, createdBy: $eventCreatedBy, idUser: $eventUserID)';
  }

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.eventID == eventID &&
      other.eventPhotoUrl == eventPhotoUrl &&
      other.eventDescription == eventDescription &&
      other.eventName == eventName &&
      other.eventLocation == eventLocation &&
      other.eventStartDate == eventStartDate &&
      other.eventEndDate == eventEndDate &&
      other.eventStartHour == eventStartHour &&
      other.eventEndHour == eventEndHour &&
      other.eventCreatedBy == eventCreatedBy &&
      other.eventUserID == eventUserID;
  }

  @override
  int get hashCode {
    return eventID.hashCode ^
      eventPhotoUrl.hashCode ^
      eventDescription.hashCode ^
      eventName.hashCode ^
      eventLocation.hashCode ^
      eventStartDate.hashCode ^
      eventEndDate.hashCode ^
      eventStartHour.hashCode ^
      eventEndHour.hashCode ^
      eventCreatedBy.hashCode ^
      eventUserID.hashCode;
  }
}
