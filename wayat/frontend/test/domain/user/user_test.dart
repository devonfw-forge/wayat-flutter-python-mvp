import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/user/user.dart';

void main() {
  late User user;
  setUp(() {
    user = User(
        id: "1",
        name: "test_name",
        email: "test@mail.com",
        imageUrl: "url://image",
        phone: "600600600");
  });

  test("Checking attributes", () {
    expect(user.id, "1");
    expect(user.name, "test_name");
    expect(user.email, "test@mail.com");
    expect(user.imageUrl, "url://image");
    expect(user.phone, "600600600");
  });

  test("Checking copy method", () {
    User userCopy = user.copyWith();
    expect(userCopy.id, "1");
    expect(userCopy.name, "test_name");
    expect(userCopy.email, "test@mail.com");
    expect(userCopy.imageUrl, "url://image");
    expect(userCopy.phone, "600600600");

    userCopy = user.copyWith(
        id: "2",
        name: "test2_name",
        email: "test2@mail.com",
        imageUrl: "url://image2",
        phone: "123456789");

    expect(userCopy.id, "2");
    expect(userCopy.name, "test2_name");
    expect(userCopy.email, "test2@mail.com");
    expect(userCopy.imageUrl, "url://image2");
    expect(userCopy.phone, "123456789");
  });

  test("Checking string conversion", () {
    expect(user.toString(),
        "User(id: 1, name: test_name, email: test@mail.com, image_url: url://image, phone: 600600600)");
  });

  test("Checking toMap conversion", () {
    List<String> attributes = ["id", "name", "email", "image_url", "phone"];

    Map<String, dynamic> userMap = user.toMap();
    for (var key in attributes) {
      expect(userMap.containsKey(key), true);
    }
    expect(userMap["id"] == user.id, true);
    expect(userMap["name"] == user.name, true);
    expect(userMap["email"] == user.email, true);
    expect(userMap["image_url"] == user.imageUrl, true);
    expect(userMap["phone"] == user.phone, true);
  });

  test("Checking comparison operator", () {
    User user2 = user.copyWith();
    expect(user == user2, true);
    user2 = user.copyWith(id: "2");
    expect(user == user2, false);
  });

  test("Checking fromMap conversion", () {
    User userFromMap = User.fromMap(user.toMap());
    expect(userFromMap == user, true);
  });

  test("Checking toJson conversion", () {
    expect(json.encode(user.toMap()) == user.toJson(), true);
  });

  test("Checking fromJson conversion", () {
    expect(user == User.fromJson(user.toJson()), true);
  });

  test("Checking hashCode", () {
    expect(user.hashCode == user.copyWith().hashCode, true);
    expect(user.hashCode == user.copyWith(id: "2").hashCode, false);
  });
}
