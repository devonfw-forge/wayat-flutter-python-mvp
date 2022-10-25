import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/features/contacts/widgets/contacts_section_title.dart';
import 'package:wayat/features/contacts/widgets/navigation_button.dart';
import 'package:wayat/lang/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

/// List view of all friends and the access to groups
class FriendsPage extends StatelessWidget {
  /// Business logic controller
  final FriendsController controller =
      GetIt.I.get<ContactsPageController>().friendsController;

  FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //The paddings are placed individually on each item instead of on the
    //complete column as to not cut the scrolls indicators
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context),
          const SizedBox(
            height: 10,
          ),
          friendsList()
        ],
      ),
    );
  }

  /// Returns widget with the friend's list of contact filtered by the query in searchbar
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
                  onTilePressed: () {
                    List<ContactLocation> contactsStatus = GetIt.I
                        .get<LocationListener>()
                        .receiveLocationState
                        .contacts;
                    ContactLocation? currentContact =
                        contactsStatus.firstWhereOrNull(
                            (element) => element.id == contacts[index].id);
                    Contact selectedContact = currentContact ?? contacts[index];
                    GetIt.I
                        .get<HomeNavState>()
                        .setSelectedContact(selectedContact);
                    context.go('/contact/${selectedContact.id}',
                        extra: "/contacts/friends");
                  },
                  contact: contacts[index],
                  iconAction: IconButton(
                    onPressed: () async =>
                        await controller.removeContact(contacts[index]),
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

  /// Returns widget with number of friends connected and groups navigation button
  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Observer(builder: (context) {
            int numFriends = controller.filteredContacts.length;
            return ContactsSectionTitle(
              text: "${appLocalizations.friendsPageTitle} ($numFriends)",
            );
          }),
          NavigationButton(
              onTap: () => context.go('/contacts/friends/groups'),
              text: appLocalizations.groupsTitle)
        ],
      ),
    );
  }
}
