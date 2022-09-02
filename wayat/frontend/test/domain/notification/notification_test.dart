import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/notification/notification.dart';

void main() {
  late Notification notification;
  setUp(() {
    notification = Notification(
        notificationID: 1,
        notificationType: "type notification",
        eventID: 2,
        eventName: "Event Name",
        eventLocation: "Location of the event",
        eventStartDate: "12/3/4",
        eventEndDate: "13/3/4",
        eventStartHour: "4:56",
        eventEndHour: "7:23",
        invitedBy: "Other user",
        invitedByID: 3,
        invitedUser: "Invited user",
        invitedUserID: 4);
  });

  test("Checking attributes", () {
    expect(notification.notificationID, 1);
    expect(notification.notificationType, "type notification");
    expect(notification.eventID, 2);
    expect(notification.eventName, "Event Name");
    expect(notification.eventLocation, "Location of the event");
    expect(notification.eventStartDate, "12/3/4");
    expect(notification.eventEndDate, "13/3/4");
    expect(notification.eventStartHour, "4:56");
    expect(notification.eventEndHour, "7:23");
    expect(notification.invitedBy, "Other user");
    expect(notification.invitedByID, 3);
    expect(notification.invitedUser, "Invited user");
    expect(notification.invitedUserID, 4);
  });

  test("Checking copy method", () {
    Notification notificationCopy = notification.copyWith();
    expect(notification.notificationID, 1);
    expect(notification.notificationType, "type notification");
    expect(notification.eventID, 2);
    expect(notification.eventName, "Event Name");
    expect(notification.eventLocation, "Location of the event");
    expect(notification.eventStartDate, "12/3/4");
    expect(notification.eventEndDate, "13/3/4");
    expect(notification.eventStartHour, "4:56");
    expect(notification.eventEndHour, "7:23");
    expect(notification.invitedBy, "Other user");
    expect(notification.invitedByID, 3);
    expect(notification.invitedUser, "Invited user");
    expect(notification.invitedUserID, 4);

    notificationCopy = notification.copyWith(
        notificationID: 5,
        notificationType: "type notification 2",
        eventID: 6,
        eventName: "Event Name 2",
        eventLocation: "Location of the event 2",
        eventStartDate: "2/3/4",
        eventEndDate: "3/3/4",
        eventStartHour: "14:56",
        eventEndHour: "17:23",
        invitedBy: "Other user 2",
        invitedByID: 7,
        invitedUser: "Invited user 2",
        invitedUserID: 8);

    expect(notificationCopy.notificationID, 5);
    expect(notificationCopy.notificationType, "type notification 2");
    expect(notificationCopy.eventID, 6);
    expect(notificationCopy.eventName, "Event Name 2");
    expect(notificationCopy.eventLocation, "Location of the event 2");
    expect(notificationCopy.eventStartDate, "2/3/4");
    expect(notificationCopy.eventEndDate, "3/3/4");
    expect(notificationCopy.eventStartHour, "14:56");
    expect(notificationCopy.eventEndHour, "17:23");
    expect(notificationCopy.invitedBy, "Other user 2");
    expect(notificationCopy.invitedByID, 7);
    expect(notificationCopy.invitedUser, "Invited user 2");
    expect(notificationCopy.invitedUserID, 8);
  });

  test("Checking string conversion", () {
    expect(notification.toString(),
        "Notification(notificationID: 1, notificationType: type notification, eventID: 2, eventName: Event Name, eventLocation: Location of the event, eventStartDate: 12/3/4, eventEndDate: 13/3/4, eventStartHour: 4:56, eventEndHour: 7:23, invitedBy: Other user, invitedByID: 3, invitedUser: Invited user, invitedUserID: 4)");
  });

  test("Checking toMap conversion", () {
    List<String> attributes = [
      'notificationID',
      'notificationType',
      'eventID',
      'eventName',
      'eventLocation',
      'eventStartDate',
      'eventEndDate',
      'eventStartHour',
      'eventEndHour',
      'invitedBy',
      'invitedByID',
      'invitedUser',
      'invitedUserID'
    ];

    Map<String, dynamic> notificationMap = notification.toMap();
    for (var key in attributes) {
      expect(notificationMap.containsKey(key), true);
    }
    expect(
        notificationMap["notificationID"] == notification.notificationID, true);
    expect(notificationMap["notificationType"] == notification.notificationType,
        true);
    expect(notificationMap["eventID"] == notification.eventID, true);
    expect(notificationMap["eventName"] == notification.eventName, true);
    expect(
        notificationMap["eventLocation"] == notification.eventLocation, true);
    expect(
        notificationMap["eventStartDate"] == notification.eventStartDate, true);
    expect(notificationMap["eventEndDate"] == notification.eventEndDate, true);
    expect(
        notificationMap["eventStartHour"] == notification.eventStartHour, true);
    expect(notificationMap["eventEndHour"] == notification.eventEndHour, true);
    expect(notificationMap["invitedBy"] == notification.invitedBy, true);
    expect(notificationMap["invitedByID"] == notification.invitedByID, true);
    expect(notificationMap["invitedUser"] == notification.invitedUser, true);
    expect(
        notificationMap["invitedUserID"] == notification.invitedUserID, true);
  });

  test("Checking comparison operator", () {
    Notification notification2 = notification.copyWith();
    expect(notification == notification2, true);
    notification2 = notification.copyWith(notificationID: 2);
    expect(notification == notification2, false);
  });

  test("Checking fromMap conversion", () {
    Notification notificationFromMap =
        Notification.fromMap(notification.toMap());
    expect(notificationFromMap == notification, true);
  });

  test("Checking toJson conversion", () {
    expect(json.encode(notification.toMap()) == notification.toJson(), true);
  });

  test("Checking fromJson conversion", () {
    expect(notification == Notification.fromJson(notification.toJson()), true);
  });

  test("Checking hashCode", () {
    expect(notification.hashCode == notification.copyWith().hashCode, true);
    expect(notification.hashCode == notification.copyWith(eventID: 14).hashCode,
        false);
  });
}
