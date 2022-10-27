import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/controller/onboarding_state.dart';
import 'package:wayat/features/onboarding/widgets/selected_contacts.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/import_contacts_list.dart';
import 'package:wayat/features/onboarding/widgets/initial_manage_tip.dart';
import 'package:wayat/lang/app_localizations.dart';

class ProgressOnboardingPage extends StatelessWidget {
  final OnboardingController controller = GetIt.I.get<OnboardingController>();
  final totalPages = OnBoardingProgress.values.length;

  ProgressOnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(40), child: CustomAppBar()),
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
                  bool movedBack = controller.moveBack();
                  if (!movedBack) {
                    controller.setOnBoardingState(OnBoardingState.notStarted);
                  }
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          Flexible(flex: 3, child: linearProgressIndicator()),
          Flexible(
            flex: 1,
            child: TextButton(
                onPressed: () {
                  controller.finishOnBoarding();
                  context.go('/map');
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
          value: (controller.currentPage.index + 1) / totalPages,
          color: ColorTheme.primaryColor,
          backgroundColor: ColorTheme.primaryColorDimmed,
        ),
      );
    });
  }

  //This needs to be changed when every piece of the onboarding is merged
  Widget currentBody() {
    switch (controller.currentPage) {
      case OnBoardingProgress.initialManageContactsTip:
        return InitialManageContactsTip();
      case OnBoardingProgress.importAddressBookContacts:
        return ImportedContactsList();
      case OnBoardingProgress.sendRequests:
        return SelectedContacts();
      default:
        return InitialManageContactsTip();
    }
  }
}
