import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/event/event.dart';

void main() {
  late Event event;
  setUp(() {
    event = Event(
      eventID: 1,
      eventPhotoUrl: "url://eventimage",
      eventDescription: "description",
      eventName: "Event name",
      eventLocation: "Location event",
      eventStartDate: "12/3/4",
      eventEndDate: "12/3/4",
      eventStartHour: "13:45",
      eventEndHour: "13:50",
      eventCreatedBy: "Creator",
      eventUserID: 1,
    );
  });

  test("Checking attributes", () {
    expect(event.eventID, 1);
    expect(event.eventPhotoUrl, "url://eventimage");
    expect(event.eventDescription, "description");
    expect(event.eventName, "Event name");
    expect(event.eventLocation, "Location event");
    expect(event.eventStartDate, "12/3/4");
    expect(event.eventEndDate, "12/3/4");
    expect(event.eventStartHour, "13:45");
    expect(event.eventEndHour, "13:50");
    expect(event.eventCreatedBy, "Creator");
    expect(event.eventUserID, 1);
  });

  test("Checking copy method", () {
    Event eventCopy = event.copyWith();
    expect(eventCopy.eventID, 1);
    expect(eventCopy.eventPhotoUrl, "url://eventimage");
    expect(eventCopy.eventDescription, "description");
    expect(eventCopy.eventName, "Event name");
    expect(eventCopy.eventLocation, "Location event");
    expect(eventCopy.eventStartDate, "12/3/4");
    expect(eventCopy.eventEndDate, "12/3/4");
    expect(eventCopy.eventStartHour, "13:45");
    expect(eventCopy.eventEndHour, "13:50");
    expect(eventCopy.eventCreatedBy, "Creator");
    expect(eventCopy.eventUserID, 1);

    eventCopy = event.copyWith(
        idEvent: 2,
        photoUrl: "url://eventimage2",
        description: "description2",
        eventName: "Event name 2",
        eventLocation: "Location event 2",
        eventStartDate: "13/3/4",
        eventEndDate: "12/10/5",
        eventStartHour: "1:45",
        eventEndHour: "2:50",
        createdBy: "Creator2",
        idUser: 2);

    expect(eventCopy.eventID, 2);
    expect(eventCopy.eventPhotoUrl, "url://eventimage2");
    expect(eventCopy.eventDescription, "description2");
    expect(eventCopy.eventName, "Event name 2");
    expect(eventCopy.eventLocation, "Location event 2");
    expect(eventCopy.eventStartDate, "13/3/4");
    expect(eventCopy.eventEndDate, "12/10/5");
    expect(eventCopy.eventStartHour, "1:45");
    expect(eventCopy.eventEndHour, "2:50");
    expect(eventCopy.eventCreatedBy, "Creator2");
    expect(eventCopy.eventUserID, 2);
  });

  test("Checking string conversion", () {
    expect(event.toString(),
        "Event(idEvent: 1, photoUrl: url://eventimage, description: description, eventName: Event name, eventLocation: Location event, eventStartDate: 12/3/4, eventEndDate: 12/3/4, eventStartHour: 13:45, eventEndHour: 13:50, createdBy: Creator, idUser: 1)");
  });

  test("Checking toMap conversion", () {
    List<String> attributes = [
      'idEvent',
      'photoUrl',
      'description',
      'eventName',
      'eventLocation',
      'eventStartDate',
      'eventEndDate',
      'eventStartHour',
      'eventEndHour',
      'createdBy',
      'idUser'
    ];

    Map<String, dynamic> eventMap = event.toMap();
    for (var key in attributes) {
      expect(eventMap.containsKey(key), true);
    }
    expect(eventMap['idEvent'] == event.eventID, true);
    expect(eventMap['photoUrl'] == event.eventPhotoUrl, true);
    expect(eventMap['description'] == event.eventDescription, true);
    expect(eventMap['eventName'] == event.eventName, true);
    expect(eventMap['eventLocation'] == event.eventLocation, true);
    expect(eventMap['eventStartDate'] == event.eventStartDate, true);
    expect(eventMap['eventEndDate'] == event.eventEndDate, true);
    expect(eventMap['eventStartHour'] == event.eventStartHour, true);
    expect(eventMap['eventEndHour'] == event.eventEndHour, true);
    expect(eventMap['createdBy'] == event.eventCreatedBy, true);
    expect(eventMap['idUser'] == event.eventUserID, true);
  });

  test("Checking comparison operator", () {
    Event event2 = event.copyWith();
    expect(event == event2, true);
    event2 = event.copyWith(idEvent: 2);
    expect(event == event2, false);
  });

  test("Checking fromMap conversion", () {
    Event eventFromMap = Event.fromMap(event.toMap());
    expect(eventFromMap == event, true);
  });

  test("Checking toJson conversion", () {
    expect(json.encode(event.toMap()) == event.toJson(), true);
  });

  test("Checking fromJson conversion", () {
    expect(event == Event.fromJson(event.toJson()), true);
  });

  test("Checking hashCode", () {
    expect(event.hashCode == event.copyWith().hashCode, true);
    expect(event.hashCode == event.copyWith(idEvent: 2).hashCode, false);
  });
}
