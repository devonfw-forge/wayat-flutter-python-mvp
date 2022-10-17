// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:location/location.dart';

class LastWebLocation {
  final LocationData lastLocation;
  final DateTime updatedDateTime;
  LastWebLocation({
    required this.lastLocation,
    required this.updatedDateTime,
  });

  LastWebLocation copyWith({
    LocationData? lastLocation,
    DateTime? updatedDateTime,
  }) {
    return LastWebLocation(
      lastLocation: lastLocation ?? this.lastLocation,
      updatedDateTime: updatedDateTime ?? this.updatedDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastLocation': {
        'latitude': lastLocation.latitude,
        'longitude': lastLocation.longitude
      },
      'updatedTimestamp': updatedDateTime.toString(),
    };
  }

  factory LastWebLocation.fromMap(Map<String, dynamic> map) {
    return LastWebLocation(
      lastLocation:
          LocationData.fromMap(map['lastLocation'] as Map<String, dynamic>),
      updatedDateTime: DateTime.parse(map['updatedTimestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LastWebLocation.fromJson(String source) =>
      LastWebLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LastWebLocation(lastLocation: $lastLocation, updatedTimestamp: $updatedDateTime)';

  @override
  bool operator ==(covariant LastWebLocation other) {
    if (identical(this, other)) return true;

    return other.lastLocation == lastLocation &&
        other.updatedDateTime == updatedDateTime;
  }

  @override
  int get hashCode => lastLocation.hashCode ^ updatedDateTime.hashCode;
}
