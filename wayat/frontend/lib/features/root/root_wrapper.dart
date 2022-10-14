import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Wrapper to redirect the user to the correct screen when starting the app.
///
/// If the user has not logged in yet, they will be redirected to the login page.
///
/// If the user has logged in previously, and has completed the onBoarding
/// process, they will be redirected to the main page of the app.
///
/// Lastly, if the user has logged previously, but has not completed the OnBoarding,
/// they will be redirected to the OnBoarding page.
class RootWrapper extends StatelessWidget {
  final UserState userState = GetIt.I.get<UserState>();

  RootWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      bool loggedIn = userState.finishLoggedIn;
      bool doneOnBoarding = userState.hasDoneOnboarding;
      return AutoRouter.declarative(
          routes: (_) => [
                if (loggedIn)
                  if (!doneOnBoarding && !PlatformService().isWeb)
                    OnBoardingWrapper()
                  else
                    HomeWrapper()
                else
                  LoginWrapper()
              ]);
    });
  }
}
