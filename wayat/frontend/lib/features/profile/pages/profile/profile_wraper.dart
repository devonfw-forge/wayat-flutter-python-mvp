import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class ProfileWrapper extends StatelessWidget {
  final ProfileState controller = GetIt.I.get<ProfileState>();

  ProfileWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      ProfileCurrentPages currentPage = controller.currentPage;

      return Builder(builder: (_) {
        return AutoRouter.declarative(
            routes: (_) => [
                  ProfileRoute(),
                  if (currentPage != ProfileCurrentPages.profile)
                    getCurrentPage(currentPage)
                ]);
      });
    });
  }

  PageRouteInfo getCurrentPage(ProfileCurrentPages currentPage) {
    switch (currentPage) {
      case ProfileCurrentPages.editProfile:
        return const EditProfileRoute();
      case ProfileCurrentPages.preference:
        return const PreferencesRoute();
      case ProfileCurrentPages.faqs:
        return const FaqsRoute();
      case ProfileCurrentPages.privacy:
        return const PrivacyRoute();
      case ProfileCurrentPages.profile:
        return ProfileRoute();
    }
  }
}
