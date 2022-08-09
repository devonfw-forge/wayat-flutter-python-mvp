import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      case OnBoardingState.NotStarted:
        return OnBoardingRoute();
      case OnBoardingState.Current:
        return ProgressOnboardingRoute();
    }
  }
}
