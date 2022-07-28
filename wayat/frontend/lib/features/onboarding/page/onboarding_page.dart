import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
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
              height: 50,
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
      ])),
    );
  }
}
