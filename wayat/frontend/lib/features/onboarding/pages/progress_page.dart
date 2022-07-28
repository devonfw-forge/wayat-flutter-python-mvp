import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/features/onboarding/widgets/manage_contacts.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';

class ProgressOnboardingPage extends StatefulWidget {
  const ProgressOnboardingPage({Key? key}) : super(key: key);

  @override
  State<ProgressOnboardingPage> createState() => _ProgressOnboardingPageState();
}

class _ProgressOnboardingPageState extends State<ProgressOnboardingPage> {
  final totalPages = 3;
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40), child: CustomAppBar()),
      body: Column(
        children: [onBoardingHeader(context), currentBody()],
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
                onPressed: () => AutoRouter.of(context).pop(),
                icon: const Icon(Icons.arrow_back)),
          ),
          Flexible(flex: 3, child: linearProgressIndicator()),
          Flexible(
            flex: 1,
            child: TextButton(
                onPressed: () => {},
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: LinearProgressIndicator(
        value: currentPage / totalPages,
        color: ColorTheme.primaryColor,
        backgroundColor: ColorTheme.primaryColorDimmed,
      ),
    );
  }

  //This needs to be changed when every piece of the onboarding is merged
  Widget currentBody() {
    switch (currentPage) {
      case 1:
        return const ManageContactsBody();
      case 2:
        return const ManageContactsBody();
      case 3:
        return const ManageContactsBody();
      default:
        return const ManageContactsBody();
    }
  }
}
