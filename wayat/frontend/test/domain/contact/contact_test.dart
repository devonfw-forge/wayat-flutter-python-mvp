import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/contact/contact.dart';

void main() {
  late Contact contact;
  setUp(() {
    contact = Contact(
        shareLocation: true,
        available: true,
        id: "1",
        name: "test_name",
        email: "test@mail.com",
        imageUrl: "url://image",
        phone: "600600600");
  });

  test("Checking attributes", () {
    expect(contact.available, true);
    expect(contact.id, "1");
    expect(contact.name, "test_name");
    expect(contact.email, "test@mail.com");
    expect(contact.imageUrl, "url://image");
    expect(contact.phone, "600600600");
  });

  test("Checking copy method", () {
    Contact contactCopy = contact.copyWith();
    expect(contactCopy.available, true);
    expect(contactCopy.id, "1");
    expect(contactCopy.name, "test_name");
    expect(contactCopy.email, "test@mail.com");
    expect(contactCopy.imageUrl, "url://image");
    expect(contactCopy.phone, "600600600");

    contactCopy = contact.copyWith(
        available: false,
        id: "2",
        name: "test2_name",
        email: "test2@mail.com",
        imageUrl: "url://image2",
        phone: "123456789");

    expect(contactCopy.available, false);
    expect(contactCopy.id, "2");
    expect(contactCopy.name, "test2_name");
    expect(contactCopy.email, "test2@mail.com");
    expect(contactCopy.imageUrl, "url://image2");
    expect(contactCopy.phone, "123456789");
  });

  test("Checking string conversion", () {
    expect(contact.toString(),
        "Contact(id: 1, available: true, name: test_name, email: test@mail.com, imageUrl: url://image, phone: 600600600, shareLocation: true)");
  });

  test("Checking toMap conversion", () {
    List<String> attributes = [
      "id",
      "available",
      "name",
      "email",
      "image_url",
      "phone"
    ];

    Map<String, dynamic> contactMap = contact.toMap();
    for (var key in attributes) {
      expect(contactMap.containsKey(key), true);
    }
    expect(contactMap["id"] == contact.id, true);
    expect(contactMap["available"] == contact.available, true);
    expect(contactMap["name"] == contact.name, true);
    expect(contactMap["email"] == contact.email, true);
    expect(contactMap["image_url"] == contact.imageUrl, true);
    expect(contactMap["phone"] == contact.phone, true);
  });

  test("Checking comparison operator", () {
    Contact contact2 = contact.copyWith();
    expect(contact == contact2, true);
    contact2 = contact.copyWith(id: "2");
    expect(contact == contact2, false);
  });

  test("Checking fromMap conversion", () {
    Contact contactFromMap = Contact.fromMap(contact.toMap());
    expect(contactFromMap == contact, true);
  });

  test("Checking toJson conversion", () {
    expect(json.encode(contact.toMap()) == contact.toJson(), true);
  });

  test("Checking fromJson conversion", () {
    expect(contact == Contact.fromJson(contact.toJson()), true);
  });

  test("Checking hashCode", () {
    expect(contact.hashCode == contact.copyWith().hashCode, true);
    expect(contact.hashCode == contact.copyWith(id: "2").hashCode, false);
  });
}
