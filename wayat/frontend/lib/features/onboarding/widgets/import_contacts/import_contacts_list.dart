import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/controller/onboarding_progress.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/contact_item.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';

class ImportedContactsList extends StatelessWidget {
  final OnboardingController controller = GetIt.I.get<OnboardingController>();

  ImportedContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contactListTitle(),
              azListView(context),
            ],
          ),
        ),
        nextButton(),
      ],
    );
  }

  Padding contactListTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        appLocalizations.selectContacts,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget azListView(BuildContext context) {
    return Expanded(
      child: Observer(builder: (context) {
        List<Contact> contacts = controller.contactList;
        List<AZContactItem> contactsAZ = generateContactRowData(contacts);
        return AzListView(
          data: contactsAZ,
          itemCount: contactsAZ.length,
          itemBuilder: (context, index) => azContactRow(contactsAZ[index]),
          indexBarItemHeight: MediaQuery.of(context).size.height / 42,
          indexHintBuilder: (context, hint) => Container(
            alignment: Alignment.center,
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                color: Colors.black12, shape: BoxShape.rectangle),
            child: Text(
              hint,
              style: const TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
          indexBarOptions: const IndexBarOptions(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 243, 255),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
            ),
            indexHintAlignment: Alignment.centerRight,
          ),
        );
      }),
    );
  }

  Widget nextButton() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35),
        alignment: AlignmentDirectional.bottomCenter,
        child: CustomFilledButton(
          text: appLocalizations.next,
          onPressed: () =>
              {controller.progressTo(OnBoardingProgress.sendRequests)},
          enabled: true,
        ));
  }

  List<AZContactItem> generateContactRowData(List<Contact> contactList) {
    List<AZContactItem> result = contactList
        .map((contact) =>
            AZContactItem(contact: contact, tag: contact.name[0].toUpperCase()))
        .toList();

    SuspensionUtil.sortListBySuspensionTag(result);
    SuspensionUtil.setShowSuspensionStatus(result);

    return result;
  }

  //Build sorted list of contacts
  Widget azContactRow(AZContactItem azItem) {
    final tag = azItem.getSuspensionTag();
    final offstage = !azItem.isShowSuspension;

    return Column(
      children: [
        Offstage(offstage: offstage, child: buildHeader(tag)),
        Container(
            margin: const EdgeInsets.only(right: 16),
            child: Observer(builder: (context) {
              return ContactTile(
                  contact: azItem.contact,
                  selected: controller.isSelected(azItem.contact),
                  onButtonTap: () => controller.updateSelected(azItem.contact));
            }))
      ],
    );
  }

//Build alphabet section title by first letter tag
  Widget buildHeader(String tag) {
    return Container(
      height: 21,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 30),
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        softWrap: false,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
