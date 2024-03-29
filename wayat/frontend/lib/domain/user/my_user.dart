import 'package:mobx/mobx.dart';
part 'my_user.g.dart';

/// Current data of logged user
// ignore: library_private_types_in_public_api
class MyUser = _MyUser with _$MyUser;

abstract class _MyUser with Store {
  /// Unique id of user
  String id;

  /// Current username
  @observable
  String name;

  /// email
  String email;

  /// URL to the user image
  @observable
  String imageUrl;

  /// User phone number
  @observable
  String phonePrefix;

  /// User phone number
  @observable
  String phone;

  /// Whether user finished the onboarding
  @observable
  bool onboardingCompleted;

  /// Whether user is sharing its location
  @observable
  bool shareLocationEnabled;

  _MyUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.imageUrl,
      required this.phonePrefix,
      required this.phone,
      required this.onboardingCompleted,
      required this.shareLocationEnabled});

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;
    return id == other.id &&
        name == other.name &&
        email == other.email &&
        imageUrl == other.imageUrl &&
        phonePrefix == other.phonePrefix &&
        phone == other.phone &&
        onboardingCompleted == other.onboardingCompleted &&
        shareLocationEnabled == other.shareLocationEnabled;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        imageUrl.hashCode ^
        phonePrefix.hashCode ^
        phone.hashCode ^
        onboardingCompleted.hashCode ^
        shareLocationEnabled.hashCode;
  }
}
