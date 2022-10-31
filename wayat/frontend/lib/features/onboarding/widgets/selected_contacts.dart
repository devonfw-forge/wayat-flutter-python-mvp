import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/lang/app_localizations.dart';

class SelectedContacts extends StatelessWidget {
  final OnboardingController controller = GetIt.I.get<OnboardingController>();

  SelectedContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [contactsScrollView(context), nextButton(context)],
    );
  }

  SingleChildScrollView contactsScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            contactsList(),
            CustomTextIconButton(
                text: appLocalizations.manageContacts,
                icon: Icons.edit,
                onPressed: () => controller.moveBack()),
            buttonMessageIndicator(context),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }

  Container nextButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: AlignmentDirectional.bottomCenter,
      child: CustomOutlinedButton(
          text: appLocalizations.next,
          onPressed: () {
            controller.finishOnBoarding();
            context.go('/map');
          }),
    );
  }

  Widget buttonMessageIndicator(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
              appLocalizations.manageContactsTip,
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
/*                     child:  */
    );
  }

  Widget contactsList() {
    return Observer(builder: (context) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.selectedContacts.length,
        itemBuilder: ((context, index) {
          return contactChip(index);
        }),
      );
    });
  }

  Widget contactChip(int index) {
    return Container(
      alignment: AlignmentDirectional.topStart,
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Chip(
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: Colors.black, width: 1),
          avatar:
              chipProfilePicture(controller.selectedContacts[index].imageUrl),
          labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          label: Text(
            controller.selectedContacts[index].name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          )),
    );
  }

  Widget chipProfilePicture(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: CircleAvatar(
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }
}
