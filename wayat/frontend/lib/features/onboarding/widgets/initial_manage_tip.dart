import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/lang/app_localizations.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

class InitialManageContactsTip extends StatelessWidget {
  final OnboardingController controller = GetIt.I.get<OnboardingController>();

  InitialManageContactsTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextIconButton(
            onPressed: () {
              // if (kIsWeb) {
              //   return controller
              //       .progressTo(OnBoardingProgress.sendRequests);
              // } else {
                return controller
                    .progressTo(OnBoardingProgress.importAddressBookContacts);
              // }
            },
            icon: Icons.edit,
            text: appLocalizations.manageContacts),
        const SizedBox(
          height: 50,
        ),
        manageContactsTip(context)
      ],
    );
  }

  Widget manageContactsTip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: const Image(image: AssetImage("assets/images/dialog.png")),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, bottom: 30.0, top: 40.0),
            child: Text(
              appLocalizations.importContactsTip,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: (MediaQuery.of(context).orientation ==
                          Orientation.landscape)
                      ? 28
                      : 15),
            ),
          ),
        ],
      ),
    );
  }
}
