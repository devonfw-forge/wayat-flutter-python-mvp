import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/message_card.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/lang/app_localizations.dart';

class GroupsPage extends StatelessWidget {
  final GroupsController groupsController;

  GroupsPage({GroupsController? groupsController, Key? key})
      : groupsController = groupsController ?? GroupsController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: groupsContent(),
        onWillPop: () async {
          GetIt.I
              .get<ContactsPageController>()
              .setContactsCurrentPage(ContactsCurrentPages.contacts);
          return true;
        });
  }

  Widget groupsContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          (groupsController.groups.isEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MessageCard(
                    appLocalizations.noGroupsMessage,
                    height: 80,
                  ),
                )
              // TODO: Create the groups list in the visualize groups US
              : Container()
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  onPressed: () => GetIt.I
                      .get<ContactsPageController>()
                      .setContactsCurrentPage(ContactsCurrentPages.contacts)),
              Text(
                appLocalizations.groupsTitle,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          CustomTextButton(
            onPressed: () => GetIt.I
                .get<ContactsPageController>()
                .setContactsCurrentPage(ContactsCurrentPages.manageGroup),
            text: appLocalizations.createGroup,
          )
        ],
      ),
    );
  }
}
