import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:wayat/services/share_location/last_web_location.dart';

void main() {
  test('copyWith is correct', () {
    LastWebLocation lastWebLocation = defaultLastWebLocation();
    LastWebLocation fullCopy = lastWebLocation.copyWith();
    expect(lastWebLocation, fullCopy);
    LastWebLocation partialCopy =
        lastWebLocation.copyWith(updatedDateTime: DateTime.now());
    expect(lastWebLocation.lastLocation, partialCopy.lastLocation);
    expect(
        lastWebLocation.updatedDateTime == partialCopy.updatedDateTime, false);
  });

  test('toMap is correct', () {
    Map<String, dynamic> map = {
      'lastLocation': {'latitude': 1.0, 'longitude': 1.0},
      'updatedDateTime': DateTime(1970).toString()
    };
    expect(defaultLastWebLocation().toMap(), map);
  });

  test('fromMap is correct', () {
    Map<String, dynamic> map = {
      'lastLocation': {'latitude': 1.0, 'longitude': 1.0},
      'updatedDateTime': DateTime(1970).toString()
    };

    expect(LastWebLocation.fromMap(map), defaultLastWebLocation());
  });

  test('toJson is correct', () {
    Map<String, dynamic> map = {
      'lastLocation': {'latitude': 1.0, 'longitude': 1.0},
      'updatedDateTime': DateTime(1970).toString()
    };
    expect(defaultLastWebLocation().toJson(), jsonEncode(map));
  });

  test('fromJson is correct', () {
    Map<String, dynamic> map = {
      'lastLocation': {'latitude': 1.0, 'longitude': 1.0},
      'updatedDateTime': DateTime(1970).toString()
    };
    expect(LastWebLocation.fromJson(jsonEncode(map)), defaultLastWebLocation());
  });

  test('toString is correct', () {
    LastWebLocation lastWebLocation = defaultLastWebLocation();
    expect(
        lastWebLocation.toString(),
        'LastWebLocation(lastLocation: ${lastWebLocation.lastLocation}, '
        'updatedDateTime: ${lastWebLocation.updatedDateTime})');
  });

  test('Operator == is correct', () {
    LastWebLocation lastWebLocation = defaultLastWebLocation();
    LastWebLocation fullCopy = lastWebLocation.copyWith();
    expect(lastWebLocation == fullCopy, true);
    LastWebLocation partialCopy =
        lastWebLocation.copyWith(updatedDateTime: DateTime.now());
    expect(lastWebLocation == partialCopy, false);
  });

  test('hashCode is correct', () {
    LastWebLocation lastWebLocation = defaultLastWebLocation();
    LastWebLocation fullCopy = lastWebLocation.copyWith();
    expect(lastWebLocation.hashCode, fullCopy.hashCode);
    LastWebLocation partialCopy =
        lastWebLocation.copyWith(updatedDateTime: DateTime.now());
    expect(lastWebLocation.hashCode == partialCopy.hashCode, false);
  });
}

LastWebLocation defaultLastWebLocation() {
  return LastWebLocation(
      lastLocation: LocationData.fromMap({'latitude': 1.0, 'longitude': 1.0}),
      updatedDateTime: DateTime(1970));
}
