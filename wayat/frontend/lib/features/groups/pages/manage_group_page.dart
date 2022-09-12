import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/widgets/buttons/custom_outlined_button_icon.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/custom_textfield.dart';
import 'package:wayat/common/widgets/message_card.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/features/groups/controllers/manage_group_controller/manage_group_controller.dart';
import 'package:wayat/features/groups/widgets/create_group_contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';

class ManageGroupPage extends StatelessWidget {
  final ManageGroupController controller;
  ManageGroupPage({ManageGroupController? controller, Group? group, Key? key})
      : controller = controller ?? ManageGroupController(group: group),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: manageGroupContent(context),
        onWillPop: () async {
          GetIt.I
              .get<ContactsPageController>()
              .setContactsCurrentPage(ContactsCurrentPages.groups);
          return true;
        });
  }

  Widget manageGroupContent(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              header(),
              const SizedBox(height: 20),
              groupPictureSection(),
              const SizedBox(
                height: 5,
              ),
              groupName(),
              addParticipantsSection(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => GetIt.I
                  .get<ContactsPageController>()
                  .setContactsCurrentPage(ContactsCurrentPages.groups),
              icon: const Icon(Icons.arrow_back),
              splashRadius: 20,
            ),
            Text(
              appLocalizations.newGroup,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            )
          ],
        ),
        CustomTextButton(text: appLocalizations.save, onPressed: () {}),
      ],
    );
  }

  Widget groupPictureSection() {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.black87,
              child: CircleAvatar(
                backgroundColor: Colors.black87,
                radius: 50 - 5,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 55,
                ),
              )),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          splashColor: Colors.white,
          radius: 40,
          onTap: () {},
          child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black87,
              child: CircleAvatar(
                backgroundColor: Colors.black87,
                radius: 20 - 5,
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              )),
        ),
      ],
    );
  }

  Widget groupName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField(
          controller: controller.groupNameController,
          label: appLocalizations.groupName,
          hint: appLocalizations.newGroup),
    );
  }

  Widget addParticipantsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            appLocalizations.addParticipants,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        MessageCard(
          appLocalizations.addParticipantsTip,
          height: 110,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomOutlinedButtonIcon(
            text: appLocalizations.addFriends,
            icon: Icons.add,
            onPressed: () {
              showFriendsBottomSheet(context);
            },
          ),
        )
      ],
    );
  }

  void showFriendsBottomSheet(BuildContext context) {
    showModalBottomSheet(
        barrierColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Text(
                  appLocalizations.addParticipants,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Observer(builder: (context) {
                  List<Contact> contacts = controller.allContacts;
                  List<Contact> selectedContacts = controller.selectedContacts;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => CreateGroupContactTile(
                            contact: contacts[index],
                            selected:
                                selectedContacts.contains(contacts[index]),
                            iconAction: () {
                              if (selectedContacts.contains(contacts[index])) {
                                controller.removeContact(contacts[index]);
                              } else {
                                controller.addContact(contacts[index]);
                              }
                            },
                            selectedIcon: Icons.done_outline,
                            unselectedIcon: Icons.add_circle_outline,
                          ));
                })
              ],
            )),
          );
        });
    // _draggableSheetLayer() {
    //   return DraggableScrollableSheet(
    //       minChildSize: 0.13,
    //       initialChildSize: 0.13,
    //       builder: (context, scrollController) => Container(
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 border: Border.all(width: 1, color: Colors.black),
    //                 borderRadius: const BorderRadius.only(
    //                   topLeft: Radius.circular(10),
    //                   topRight: Radius.circular(10),
    //                 )),
    //             child: _bottomSheetScrollView(scrollController),
    //           ));
    // }
  }
}
