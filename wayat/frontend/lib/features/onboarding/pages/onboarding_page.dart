import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_state.dart';
import 'package:wayat/lang/app_localizations.dart';

class OnBoardingPage extends StatelessWidget {
  final OnboardingController controller = GetIt.I.get<OnboardingController>();

  OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(alignment: AlignmentDirectional.center, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 80.0),
          child: Icon(
            Icons.location_on_outlined,
            color: ColorTheme.primaryColorTransparent,
            size: 350,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appLocalizations.appTitle,
                style: const TextStyle(
                    color: ColorTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            const SizedBox(
              height: 80,
            ),
            Text(
              appLocalizations.allowedContactsTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              appLocalizations.allowedContactsBody,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
            ),
          ],
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35),
            alignment: AlignmentDirectional.bottomCenter,
            child: CustomOutlinedButton(
                text: appLocalizations.next,
                onPressed: () {
                  controller.setOnBoardingState(OnBoardingState.current);
                  context.go('/onboarding/progress');
                }))
      ])),
    );
  }
}
