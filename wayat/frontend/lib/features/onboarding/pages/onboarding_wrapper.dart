import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_state.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class OnBoardingWrapper extends StatelessWidget {
  final OnboardingController controller = GetIt.I.get<OnboardingController>();

  OnBoardingWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      OnBoardingState state = controller.onBoardingState;
      return AutoRouter.declarative(routes: (_) => [getRoute(state)]);
    });
  }

  PageRouteInfo<dynamic> getRoute(OnBoardingState state) {
    switch (state) {
      case OnBoardingState.notStarted:
        return OnBoardingRoute();
      case OnBoardingState.current:
        return ProgressOnboardingRoute();
    }
  }
}
