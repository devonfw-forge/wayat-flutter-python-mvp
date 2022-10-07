import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/features/profile/controllers/profile_controller.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';

void main() async {
  test("Initial State is correct", () {
    ProfileController profileController = ProfileController();
    expect(profileController.currentPage, ProfileCurrentPages.profile);
  });
}
