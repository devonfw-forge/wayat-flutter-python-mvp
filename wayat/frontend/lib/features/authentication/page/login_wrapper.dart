import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/services/authentication/gauth_service_impl.dart';

class LoginWrapper extends StatelessWidget {
  final SessionState controller = GetIt.I.get<SessionState>();

  LoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      bool signedIn = controller.googleSignedIn;
      bool validPhone = controller.phoneValidation;
      print("OBSERVER RELOADED");
      return FutureBuilder(
          future: controller.isLogged(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data as bool) {
                print("FUTURE BUILDER RELOADED");
                controller.doLoginProcess();
              }
              return AutoRouter.declarative(
                  routes: (_) => [
                        if (!signedIn)
                          const LoginRoute()
                        else if (!validPhone)
                          const PhoneValidationRoute()
                        else
                          OnBoardingRoute()
                      ]);
            } else {
              return Container(
                color: Colors.white,
                child: const Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )),
              );
            }
          });
    });
  }
}
