import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/navigation/app_router.gr.dart';

/// Main navigator using AutoRoute
class HomeWrapper extends StatelessWidget {
  final HomeNavState homeState = GetIt.I.get<HomeNavState>();

  HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      Contact? selectedContact = homeState.selectedContact;
      return AutoRouter.declarative(
          routes: (_) => [
                HomeRoute(),
                if (selectedContact != null)
                  ContactProfileRoute(
                      contact: selectedContact,
                      navigationSource:
                          homeState.navigationSourceContactProfile)
              ]);
    });
  }
}
