import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class RootWrapper extends StatelessWidget {
  final SessionState userSession = GetIt.I.get<SessionState>();

  RootWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      bool loggedIn = userSession.isLoggedIn;
      bool doneOnBoarding = userSession.hasDoneOnboarding;
      return AutoRouter.declarative(
          routes: (_) => [
                if (loggedIn)
                  if (!doneOnBoarding)
                    OnBoardingWrapper()
                  else
                    const HomeRoute()
                else
                  const LoginRoute()
              ]);
    });
  }
}
