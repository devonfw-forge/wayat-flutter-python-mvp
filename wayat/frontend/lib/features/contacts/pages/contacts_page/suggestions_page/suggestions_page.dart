import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/buttons/invite_wayat.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/features/contacts/widgets/contacts_section_title.dart';
import 'package:wayat/lang/app_localizations.dart';

/// List view of all suggested friends and the access to groups and a dialog to
/// copy an invitation text
class SuggestionsPage extends StatelessWidget {
  /// Business logic controller
  final SuggestionsController suggestionsController =
      GetIt.I.get<ContactsPageController>().suggestionsController;

  SuggestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //The paddings are placed individually on each item instead of on the
    //complete column as to not cut the scrolls indicators
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInviteWayat(onCopyInvitation: () {
            suggestionsController.copyInvitation().then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(appLocalizations.invitationCopied)));
            });
          }),
          header(),
          const SizedBox(
            height: 10,
          ),
          suggestionsList()
        ],
      ),
    );
  }

  /// Returns widget with the suggested contacts list filtered by the query in searchbar
  Widget suggestionsList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
      child: Observer(builder: (context) {
        List<Contact> contacts = suggestionsController.filteredSuggestions;

        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contacts.length,
            itemBuilder: (context, index) => ContactTile(
                  contact: contacts[index],
                  iconAction: IconButton(
                    onPressed: () async => await suggestionsController
                        .sendRequest(contacts[index]),
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: ColorTheme.primaryColor,
                    ),
                    splashRadius: 20,
                  ),
                ));
      }),
    );
  }

  /// Returns widget with title Add Your Contacts
  Widget header() {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
        child: ContactsSectionTitle(
          text: appLocalizations.suggestionsPageTitle,
        ));
  }
}
