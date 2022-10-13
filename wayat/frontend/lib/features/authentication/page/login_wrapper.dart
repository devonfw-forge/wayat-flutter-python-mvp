import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/common/widgets/loading_widget.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Wrapper for Login navigation
class LoginWrapper extends StatelessWidget {
  final UserState controller = GetIt.I.get<UserState>();

  LoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      Future<bool> isLogged = controller.isLogged();
      MyUser? currentUser = controller.currentUser;
      return FutureBuilder(
          future: isLogged,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              bool isLogged = snapshot.data as bool;
              return FutureBuilder(
                  future: controller.initializeCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AutoRouter.declarative(
                          routes: (_) => [
                                if (!isLogged)
                                  const LoginRoute()
                                else if (currentUser != null &&
                                    currentUser.phone == "" &&
                                    !PlatformService().isWeb)
                                  PhoneValidationRoute()
                                else
                                  CannotLoginRoute()
                              ]);
                    } else {
                      return const LoadingWidget();
                    }
                  });
            } else {
              return const LoadingWidget();
            }
          });
    });
  }
}
