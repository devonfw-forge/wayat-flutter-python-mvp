import 'package:wayat/domain/user/my_user.dart';

class MyUserFactory {
  static MyUser fromMap(Map<String, dynamic> myUserMap) {
    return MyUser(
        id: myUserMap['id'] as String,
        name: myUserMap['name'] as String,
        email: myUserMap['email'] as String,
        imageUrl: myUserMap['image_url'] as String,
        phone: myUserMap['phone'] ?? "",
        onboardingCompleted: myUserMap['onboarding_completed'] as bool,
        shareLocationEnabled: myUserMap['share_location'] as bool);
  }
}
