import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/event/event.dart';

void main() {
  late Event event;
  setUp(() {
    event = Event(
      id: 1,
      photoUrl: "url://eventimage",
      description: "description",
      name: "Event name",
      location: "Location event",
      startDate: "12/3/4",
      endDate: "12/3/4",
      startHour: "13:45",
      endHour: "13:50",
      createdBy: "Creator",
      userId: 1,
    );
  });

  test("Checking attributes", () {
    expect(event.id, 1);
    expect(event.photoUrl, "url://eventimage");
    expect(event.description, "description");
    expect(event.name, "Event name");
    expect(event.location, "Location event");
    expect(event.startDate, "12/3/4");
    expect(event.endDate, "12/3/4");
    expect(event.startHour, "13:45");
    expect(event.endHour, "13:50");
    expect(event.createdBy, "Creator");
    expect(event.userId, 1);
  });

  test("Checking copy method", () {
    Event eventCopy = event.copyWith();
    expect(eventCopy.id, 1);
    expect(eventCopy.photoUrl, "url://eventimage");
    expect(eventCopy.description, "description");
    expect(eventCopy.name, "Event name");
    expect(eventCopy.location, "Location event");
    expect(eventCopy.startDate, "12/3/4");
    expect(eventCopy.endDate, "12/3/4");
    expect(eventCopy.startHour, "13:45");
    expect(eventCopy.endHour, "13:50");
    expect(eventCopy.createdBy, "Creator");
    expect(eventCopy.userId, 1);

    eventCopy = event.copyWith(
        id: 2,
        photoUrl: "url://eventimage2",
        description: "description2",
        name: "Event name 2",
        location: "Location event 2",
        startDate: "13/3/4",
        endDate: "12/10/5",
        startHour: "1:45",
        endHour: "2:50",
        createdBy: "Creator2",
        userId: 2);

    expect(eventCopy.id, 2);
    expect(eventCopy.photoUrl, "url://eventimage2");
    expect(eventCopy.description, "description2");
    expect(eventCopy.name, "Event name 2");
    expect(eventCopy.location, "Location event 2");
    expect(eventCopy.startDate, "13/3/4");
    expect(eventCopy.endDate, "12/10/5");
    expect(eventCopy.startHour, "1:45");
    expect(eventCopy.endHour, "2:50");
    expect(eventCopy.createdBy, "Creator2");
    expect(eventCopy.userId, 2);
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
    expect(eventMap['idEvent'] == event.id, true);
    expect(eventMap['photoUrl'] == event.photoUrl, true);
    expect(eventMap['description'] == event.description, true);
    expect(eventMap['eventName'] == event.name, true);
    expect(eventMap['eventLocation'] == event.location, true);
    expect(eventMap['eventStartDate'] == event.startDate, true);
    expect(eventMap['eventEndDate'] == event.endDate, true);
    expect(eventMap['eventStartHour'] == event.startHour, true);
    expect(eventMap['eventEndHour'] == event.endHour, true);
    expect(eventMap['createdBy'] == event.createdBy, true);
    expect(eventMap['idUser'] == event.userId, true);
  });

  test("Checking comparison operator", () {
    Event event2 = event.copyWith();
    expect(event == event2, true);
    event2 = event.copyWith(id: 2);
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
    expect(event.hashCode == event.copyWith(id: 2).hashCode, false);
  });
}
