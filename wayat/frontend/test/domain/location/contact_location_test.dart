import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/location/contact_location.dart';

void main() {
  late ContactLocation contactLocation;
  setUp(() {
    contactLocation = ContactLocation(
        available: true,
        id: "1",
        name: "test_name",
        email: "test@mail.com",
        imageUrl: "url://image",
        phone: "600600600",
        address: 'Calle Desconocida, 3',
        lastUpdated: DateTime(2021, 1, 1, 13, 54, 22),
        latitude: 43.24,
        longitude: -56.23);
  });

  test("Checking attributes", () {
    expect(contactLocation.available, true);
    expect(contactLocation.id, "1");
    expect(contactLocation.name, "test_name");
    expect(contactLocation.email, "test@mail.com");
    expect(contactLocation.imageUrl, "url://image");
    expect(contactLocation.phone, "600600600");
    expect(contactLocation.address, 'Calle Desconocida, 3');
    expect(contactLocation.lastUpdated, DateTime(2021, 1, 1, 13, 54, 22));
    expect(contactLocation.latitude, 43.24);
    expect(contactLocation.longitude, -56.23);
  });

  test("Checking copy method", () {
    ContactLocation contactLocationCopy = contactLocation.copyWith();
    expect(contactLocationCopy.available, true);
    expect(contactLocationCopy.id, "1");
    expect(contactLocationCopy.name, "test_name");
    expect(contactLocationCopy.email, "test@mail.com");
    expect(contactLocationCopy.imageUrl, "url://image");
    expect(contactLocationCopy.phone, "600600600");
    expect(contactLocation.address, 'Calle Desconocida, 3');
    expect(contactLocation.lastUpdated, DateTime(2021, 1, 1, 13, 54, 22));
    expect(contactLocation.latitude, 43.24);
    expect(contactLocation.longitude, -56.23);

    contactLocationCopy = contactLocation.copyWith(
        available: false,
        id: "2",
        name: "test2_name",
        email: "test2@mail.com",
        imageUrl: "url://image2",
        phone: "123456789",
        address: 'Calle Unknown 123',
        lastUpdated: DateTime(2022, 2, 3, 12, 34, 12),
        latitude: -34.24,
        longitude: 23.23);

    expect(contactLocationCopy.available, false);
    expect(contactLocationCopy.id, "2");
    expect(contactLocationCopy.name, "test2_name");
    expect(contactLocationCopy.email, "test2@mail.com");
    expect(contactLocationCopy.imageUrl, "url://image2");
    expect(contactLocationCopy.phone, "123456789");
    expect(contactLocationCopy.address, 'Calle Unknown 123');
    expect(contactLocationCopy.lastUpdated, DateTime(2022, 2, 3, 12, 34, 12));
    expect(contactLocationCopy.latitude, -34.24);
    expect(contactLocationCopy.longitude, 23.23);
  });

  test("Checking toMap conversion", () {
    List<String> attributes = [
      "id",
      "available",
      "name",
      "email",
      "image_url",
      "phone",
      "address",
      "lastUpdated",
      "latitude",
      "longitude"
    ];

    Map<String, dynamic> contactLocationMap = contactLocation.toMap();
    for (var key in attributes) {
      expect(contactLocationMap.containsKey(key), true);
    }
    expect(contactLocationMap["id"] == contactLocation.id, true);
    expect(contactLocationMap["available"] == contactLocation.available, true);
    expect(contactLocationMap["name"] == contactLocation.name, true);
    expect(contactLocationMap["email"] == contactLocation.email, true);
    expect(contactLocationMap["image_url"] == contactLocation.imageUrl, true);
    expect(contactLocationMap["phone"] == contactLocation.phone, true);
    expect(contactLocationMap["address"] == contactLocation.address, true);
    expect(
        contactLocationMap["lastUpdated"]
                .compareTo(contactLocation.lastUpdated) ==
            0,
        true);
    expect(contactLocationMap["latitude"] == contactLocation.latitude, true);
    expect(contactLocationMap["longitude"] == contactLocation.longitude, true);
  });

  test("Checking comparison operator", () {
    ContactLocation contactLocation2 = contactLocation.copyWith();
    expect(contactLocation == contactLocation2, true);
    contactLocation2 = contactLocation.copyWith(id: "2");
    expect(contactLocation == contactLocation2, false);
  });

  test("Checking fromMap conversion", () {
    ContactLocation contactLocationFromMap =
        ContactLocation.fromMap(contactLocation.toMap());
    expect(contactLocationFromMap == contactLocation, true);
  });

  test("Checking hashCode", () {
    expect(
        contactLocation.hashCode == contactLocation.copyWith().hashCode, true);
    expect(
        contactLocation.hashCode == contactLocation.copyWith(id: "2").hashCode,
        false);
  });
}
