import 'package:flutter/material.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/navigation/bottom_navigation_bar/items_bottom_navigation_bar.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class AddContactsPage extends StatelessWidget {
  final List<Contact> contacts = ContactsMock.availableContacts();
  //final List<Contact> contacts;

  AddContactsPage({Key? key}) : super(key: key);
  //AddContactsPage({required this.contacts, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [contactsScrollView(context), nextButton()],
      ),
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
                text: "Manage contacts",
                icon: Icons.edit,
                onPressed: () => debugPrint("Pressed")),
            buttonMessageIndicator(context),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }

  Container nextButton() {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: AlignmentDirectional.bottomCenter,
      child: CustomOutlinedButton(
          text: appLocalizations.next, onPressed: () => debugPrint("Pressed")),
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
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: contacts.length,
      itemBuilder: ((context, index) {
        return contactChip(index);
      }),
    );
  }

  Widget contactChip(int index) {
    return Container(
      alignment: AlignmentDirectional.topStart,
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Chip(
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: Colors.black, width: 1),
          avatar: chipProfilePicture(
              "https://i.pravatar.cc/150?u=a042581f4e29026704d"),
          labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          label: Text(
            contacts[index].displayName,
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
