import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';

void main() {
  Contact testContact = Contact(
      shareLocation: true,
      available: true,
      id: "id",
      name: "name",
      email: "mail@mail.com",
      imageUrl: "https://example.com/contact",
      phone: "+34123456789");

  late Group group;
  setUp(() {
    group = Group(
        id: "id",
        members: [testContact],
        name: "name",
        imageUrl: "https://example.com/group");
  });

  test("Checking attributes", () {
    expect(group.id, "id");
    expect(group.members, [testContact]);
    expect(group.name, "name");
    expect(group.imageUrl, "https://example.com/group");
  });

  test("Checking copy method", () {
    Group copyGroup = group.copyWith();
    expect(copyGroup.id, "id");
    expect(copyGroup.members, [testContact]);
    expect(copyGroup.name, "name");
    expect(copyGroup.imageUrl, "https://example.com/group");

    copyGroup = group.copyWith(
        id: "anotherId",
        members: [],
        name: "anotherName",
        imageUrl: "https://image.com/group");

    expect(copyGroup.id, "anotherId");
    expect(copyGroup.members, []);
    expect(copyGroup.name, "anotherName");
    expect(copyGroup.imageUrl, "https://image.com/group");
  });

  test("Check String conversion", () {
    expect(group.toString(),
        "Group(id: id, members: [Contact(id: id, available: true, name: name, email: mail@mail.com, imageUrl: https://example.com/contact, phone: +34123456789, shareLocation: true)], name: name, imageUrl: https://example.com/group)");
  });

  test("Checking toMap conversion", () {
    List<String> attributes = ["id", "members", "name", "image_url"];

    Map<String, dynamic> groupMap = group.toMap();
    for (var key in attributes) {
      expect(groupMap.containsKey(key), true);
    }
    expect(groupMap["id"], group.id);
    expect(groupMap["members"], group.members.map((e) => e.toMap()).toList());
    expect(groupMap["name"], group.name);
    expect(groupMap["image_url"], group.imageUrl);
  });

  test("Checking comparison operator", () {
    Group group2 = group.copyWith();
    expect(group, group2);
    group2 = group.copyWith(id: "2");
    expect(group == group2, false);
  });

  test("Checking fromMap conversion", () {
    Group groupFromMap = Group.fromMap(group.toMap());
    expect(groupFromMap, group);
  });

  test("Checking toJson conversion", () {
    expect(json.encode(group.toMap()), group.toJson());
  });

  test("Checking fromJson conversion", () {
    expect(group, Group.fromJson(group.toJson()));
  });

  test("Checking hashCode", () {
    expect(group.hashCode, group.copyWith().hashCode);
    expect(group.hashCode == group.copyWith(id: "2").hashCode, false);
  });
}
