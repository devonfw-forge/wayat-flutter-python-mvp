import 'package:mobx/mobx.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
part 'profile_controller.g.dart';

// ignore: library_private_types_in_public_api
class ProfileController = _ProfileController with _$ProfileController;

/// Controls and updates user's profile
abstract class _ProfileController with Store {
  @observable
  ProfileCurrentPages currentPage = ProfileCurrentPages.profile;
}
