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
  });
}
