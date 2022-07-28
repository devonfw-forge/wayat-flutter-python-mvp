// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final notifications = notificationsFromMap(jsonString);

import 'dart:convert';

class Notification {
  final int notificationID;
  final String notificationType;
  final int eventID;
  final String eventName;
  final String eventLocation;
  final String eventStartDate;
  final String eventEndDate;
  final String eventStartHour;
  final String eventEndHour;
  final String invitedBy;
  final int invitedByID;
  final String invitedUser;
  final int invitedUserID;

  Notification({
    required this.notificationID,
    required this.notificationType,
    required this.eventID,
    required this.eventName,
    required this.eventLocation,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventStartHour,
    required this.eventEndHour,
    required this.invitedBy,
    required this.invitedByID,
    required this.invitedUser,
    required this.invitedUserID,
  });

  Notification copyWith({
    int? notificationID,
    String? notificationType,
    int? eventID,
    String? eventName,
    String? eventLocation,
    String? eventStartDate,
    String? eventEndDate,
    String? eventStartHour,
    String? eventEndHour,
    String? invitedBy,
    int? invitedByID,
    String? invitedUser,
    int? invitedUserID,
  }) {
    return Notification(
      notificationID: notificationID ?? this.notificationID,
      notificationType: notificationType ?? this.notificationType,
      eventID: eventID ?? this.eventID,
      eventName: eventName ?? this.eventName,
      eventLocation: eventLocation ?? this.eventLocation,
      eventStartDate: eventStartDate ?? this.eventStartDate,
      eventEndDate: eventEndDate ?? this.eventEndDate,
      eventStartHour: eventStartHour ?? this.eventStartHour,
      eventEndHour: eventEndHour ?? this.eventEndHour,
      invitedBy: invitedBy ?? this.invitedBy,
      invitedByID: invitedByID ?? this.invitedByID,
      invitedUser: invitedUser ?? this.invitedUser,
      invitedUserID: invitedUserID ?? this.invitedUserID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notificationID': notificationID,
      'notificationType': notificationType,
      'eventID': eventID,
      'eventName': eventName,
      'eventLocation': eventLocation,
      'eventStartDate': eventStartDate,
      'eventEndDate': eventEndDate,
      'eventStartHour': eventStartHour,
      'eventEndHour': eventEndHour,
      'invitedBy': invitedBy,
      'invitedByID': invitedByID,
      'invitedUser': invitedUser,
      'invitedUserID': invitedUserID,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      notificationID: map['notificationID'] as int,
      notificationType: map['notificationType'] as String,
      eventID: map['eventID'] as int,
      eventName: map['eventName'] as String,
      eventLocation: map['eventLocation'] as String,
      eventStartDate: map['eventStartDate'] as String,
      eventEndDate: map['eventEndDate'] as String,
      eventStartHour: map['eventStartHour'] as String,
      eventEndHour: map['eventEndHour'] as String,
      invitedBy: map['invitedBy'] as String,
      invitedByID: map['invitedByID'] as int,
      invitedUser: map['invitedUser'] as String,
      invitedUserID: map['invitedUserID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationsModel(notificationID: $notificationID, notificationType: $notificationType, eventID: $eventID, eventName: $eventName, eventLocation: $eventLocation, eventStartDate: $eventStartDate, eventEndDate: $eventEndDate, eventStartHour: $eventStartHour, eventEndHour: $eventEndHour, invitedBy: $invitedBy, invitedByID: $invitedByID, invitedUser: $invitedUser, invitedUserID: $invitedUserID)';
  }

  @override
  bool operator ==(covariant Notification other) {
    if (identical(this, other)) return true;

    return other.notificationID == notificationID &&
        other.notificationType == notificationType &&
        other.eventID == eventID &&
        other.eventName == eventName &&
        other.eventLocation == eventLocation &&
        other.eventStartDate == eventStartDate &&
        other.eventEndDate == eventEndDate &&
        other.eventStartHour == eventStartHour &&
        other.eventEndHour == eventEndHour &&
        other.invitedBy == invitedBy &&
        other.invitedByID == invitedByID &&
        other.invitedUser == invitedUser &&
        other.invitedUserID == invitedUserID;
  }

  @override
  int get hashCode {
    return notificationID.hashCode ^
        notificationType.hashCode ^
        eventID.hashCode ^
        eventName.hashCode ^
        eventLocation.hashCode ^
        eventStartDate.hashCode ^
        eventEndDate.hashCode ^
        eventStartHour.hashCode ^
        eventEndHour.hashCode ^
        invitedBy.hashCode ^
        invitedByID.hashCode ^
        invitedUser.hashCode ^
        invitedUserID.hashCode;
  }
}
