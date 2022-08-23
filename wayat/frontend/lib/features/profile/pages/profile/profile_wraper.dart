import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/features/profile/selector/profile_pages.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class ProfileWrapper extends StatelessWidget {
  final ProfileState controller = GetIt.I.get<ProfileState>();

  ProfileWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      ProfilePages currentPage = controller.currentPage;

      return Builder(builder: (_) {
        return AutoRouter.declarative(
            routes: (_) => [
                  ProfileRoute(),
                  if (currentPage != ProfilePages.profile)
                    getCurrentPage(currentPage)
                ]);
      });
    });
  }

  PageRouteInfo getCurrentPage(ProfilePages currentPage) {
    switch (currentPage) {
      case ProfilePages.editProfile:
        return const EditProfileRoute();
      case ProfilePages.preference:
        return const PreferencesRoute();
      case ProfilePages.faqs:
        return const FaqsRoute();
      case ProfilePages.privacy:
        return const PrivacyRoute();
      case ProfilePages.profile:
        return ProfileRoute();
    }
  }
}
