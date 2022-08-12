import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/page_controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/features/contacts/widgets/contacts_section_title.dart';
import 'package:wayat/lang/app_localizations.dart';

class FriendsPage extends StatelessWidget {
  final FriendsController controller =
      GetIt.I.get<ContactsPageController>().friendsController;

  FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.updateContacts();
    //The paddings are placed individually on each item instead of on the
    //complete column as to not cut the scrolls indicators
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          const SizedBox(
            height: 10,
          ),
          friendsList()
        ],
      ),
    );
  }

  Widget friendsList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
      child: Observer(builder: (context) {
        List<Contact> contacts = controller.filteredContacts;

        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contacts.length,
            itemBuilder: (context, index) => ContactTile(
                  contact: contacts[index],
                  iconAction: IconButton(
                    onPressed: () => controller.removeContact(contacts[index]),
                    icon: const Icon(
                      Icons.close,
                      color: ColorTheme.primaryColor,
                    ),
                    splashRadius: 20,
                  ),
                ));
      }),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Observer(builder: (context) {
        int numFriends = controller.filteredContacts.length;
        return ContactsSectionTitle(
          text: "${appLocalizations.friendsPageTitle} ($numFriends)",
        );
      }),
    );
  }
}
