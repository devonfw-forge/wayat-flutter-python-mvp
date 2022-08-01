import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/features/home/pages/home_page.dart';
import 'package:wayat/features/onboarding/pages/onboarding_page.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wayat/services/first_launch/first_launch_service.dart';

class LaunchPage extends StatelessWidget {
  final AppLocalizations appLocalizations =
      GetIt.I.get<LangSingleton>().appLocalizations;

  LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirstLaunchService().isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isFirstLaunch = snapshot.data as bool;

            if (isFirstLaunch) {
              return const OnBoardingPage();
            } else {
              return const HomePage();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
