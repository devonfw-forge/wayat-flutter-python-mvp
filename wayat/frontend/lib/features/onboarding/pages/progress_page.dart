import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/import_contacts_list.dart';
import 'package:wayat/features/onboarding/widgets/manage_contacts.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/navigation/app_router.gr.dart';
import 'package:wayat/services/first_launch/first_launch_service.dart';

class ProgressOnboardingPage extends StatelessWidget {
  ProgressOnboardingPage({Key? key}) : super(key: key);

  final OnboardingController controller = OnboardingController();

  final totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40), child: CustomAppBar()),
      body: Column(
        children: [
          onBoardingHeader(context),
          Expanded(
            child: Observer(builder: (context) {
              return currentBody();
            }),
          ),
        ],
      ),
    );
  }

  Widget onBoardingHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: IconButton(
                onPressed: () {
                  if (controller.currentPage > 1) {
                    controller.moveToPage(controller.currentPage - 1);
                  } else {
                    AutoRouter.of(context).pop();
                  }
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          Flexible(flex: 3, child: linearProgressIndicator()),
          Flexible(
            flex: 1,
            child: TextButton(
                onPressed: () {
                  FirstLaunchService().setFinishedOnBoarding();
                  AutoRouter.of(context).push(LaunchRoute());
                },
                child: Text(
                  appLocalizations.skip,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),
          )
        ],
      ),
    );
  }

  Widget linearProgressIndicator() {
    return Observer(builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          value: controller.currentPage / totalPages,
          color: ColorTheme.primaryColor,
          backgroundColor: ColorTheme.primaryColorDimmed,
        ),
      );
    });
  }

  //This needs to be changed when every piece of the onboarding is merged
  Widget currentBody() {
    switch (controller.currentPage) {
      case 1:
        return ManageContactsBody(controller: controller);
      case 2:
        return ImportedContactsList(
          controller: controller,
        );
      case 3:
        return ManageContactsBody(controller: controller);
      default:
        return ManageContactsBody(controller: controller);
    }
  }
}
