import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/domain/user/my_user.dart';

void main() {
  late MyUser myUser;
  setUp(() {
    myUser = MyUser(
        id: "1",
        name: "test_name",
        email: "test@mail.com",
        imageUrl: "url://image",
        phone: "600600600",
        onboardingCompleted: true,
        shareLocationEnabled: false);
  });

  test("Checking attributes", () {
    expect(myUser.id, "1");
    expect(myUser.name, "test_name");
    expect(myUser.email, "test@mail.com");
    expect(myUser.imageUrl, "url://image");
    expect(myUser.phone, "600600600");
    expect(myUser.onboardingCompleted, true);
    expect(myUser.shareLocationEnabled, false);
  });

  test("Checking copy method", () {
    MyUser myUserCopy = myUser.copyWith();
    expect(myUser.id, "1");
    expect(myUser.name, "test_name");
    expect(myUser.email, "test@mail.com");
    expect(myUser.imageUrl, "url://image");
    expect(myUser.phone, "600600600");
    expect(myUser.onboardingCompleted, true);
    expect(myUser.shareLocationEnabled, false);

    myUserCopy = myUser.copyWith(
        id: "2",
        name: "test2_name",
        email: "test2@mail.com",
        imageUrl: "url://image2",
        phone: "123456789",
        onboardingCompleted: false,
        shareLocationEnabled: true);

    expect(myUserCopy.id, "2");
    expect(myUserCopy.name, "test2_name");
    expect(myUserCopy.email, "test2@mail.com");
    expect(myUserCopy.imageUrl, "url://image2");
    expect(myUserCopy.phone, "123456789");
    expect(myUserCopy.onboardingCompleted, false);
    expect(myUserCopy.shareLocationEnabled, true);
  });

  test("Checking toMap conversion", () {
    List<String> attributes = [
      "id",
      "name",
      "email",
      "image_url",
      "phone",
      "onboarding_completed",
      "share_location"
    ];

    Map<String, dynamic> myUserMap = myUser.toMap();
    for (var key in attributes) {
      expect(myUserMap.containsKey(key), true);
    }
    expect(myUserMap["id"] == myUser.id, true);
    expect(myUserMap["name"] == myUser.name, true);
    expect(myUserMap["email"] == myUser.email, true);
    expect(myUserMap["image_url"] == myUser.imageUrl, true);
    expect(myUserMap["phone"] == myUser.phone, true);
    expect(
        myUserMap["onboarding_completed"] == myUser.onboardingCompleted, true);
    expect(myUserMap["share_location"] == myUser.shareLocationEnabled, true);
  });

  test("Checking comparison operator", () {
    MyUser myUser2 = myUser.copyWith();
    expect(myUser == myUser2, true);
    myUser2 = myUser.copyWith(id: "2");
    expect(myUser == myUser2, false);
  });

  test("Checking fromMap conversion", () {
    MyUser myUserFromMap = MyUser.fromMap(myUser.toMap());
    expect(myUserFromMap == myUser, true);
  });

  test("Checking toJson conversion", () {
    expect(json.encode(myUser.toMap()) == myUser.toJson(), true);
  });

  test("Checking fromJson conversion", () {
    expect(myUser == MyUser.fromJson(myUser.toJson()), true);
  });

  test("Checking hashCode", () {
    expect(myUser.hashCode == myUser.copyWith().hashCode, true);
    expect(myUser.hashCode == myUser.copyWith(id: "2").hashCode, false);
  });
}
