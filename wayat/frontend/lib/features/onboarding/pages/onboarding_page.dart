import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/buttons/outlined_buttons.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.all(25.0),
            alignment: AlignmentDirectional.bottomCenter,
            child: CustomOutlinedButton(
                text: appLocalizations.next,
                onPressed: () => AutoRouter.of(context)
                    .push(const ProgressOnboardingRoute())))
      ])),
    );
  }
}
