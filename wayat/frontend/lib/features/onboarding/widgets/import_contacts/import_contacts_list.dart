import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wayat/common/widgets/buttons/outlined_buttons.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/onboarding/controller/onboarding_controller.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/contact_item.dart';
import 'package:wayat/features/onboarding/widgets/import_contacts/contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class ImportedContactsList extends StatelessWidget {
  //final List<Contact> contacts;

  //const ImportedContactsList({required this.contacts, Key? key}) : super(key: key);

  final OnboardingController controller;

  const ImportedContactsList({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.addAll(ContactsMock.contacts);

    List<AZContactItem> contactsAZ = generateContactRowData();

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 120),
          child: AzListView(
            data: contactsAZ,
            itemCount: contactsAZ.length,
            itemBuilder: (context, index) => azContactRow(contactsAZ[index]),
            indexBarItemHeight: MediaQuery.of(context).size.height / 40,
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
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35),
            alignment: AlignmentDirectional.bottomCenter,
            child: CustomOutlinedButton(
                text: appLocalizations.next, onPressed: () => {})),
      ],
    );
  }

  List<AZContactItem> generateContactRowData() {
    List<AZContactItem> result = controller.contactList
        .map((contact) => AZContactItem(
            contact: contact, tag: contact.displayName[0].toUpperCase()))
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
                  selected: controller.contacts[azItem.contact]!,
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
