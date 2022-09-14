import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayat/common/widgets/buttons/custom_outlined_button_icon.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/custom_textfield.dart';
import 'package:wayat/common/widgets/message_card.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
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
          goBack();
          return true;
        });
  }

  Widget manageGroupContent(BuildContext context) {
    return Column(
      children: [
        header(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                groupPictureSection(context),
                const SizedBox(
                  height: 5,
                ),
                groupName(),
                addParticipantsSection(context),
                participantsSection(context),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
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
              onPressed: goBack,
              icon: const Icon(Icons.arrow_back),
              splashRadius: 20,
            ),
            Text(
              appLocalizations.newGroup,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            )
          ],
        ),
        CustomTextButton(
            text: appLocalizations.save,
            onPressed: () async {
              GroupsController groupsController =
                  GetIt.I.get<GroupsController>();
              groupsController.setUpdatingGroup(true);
              await controller.saveGroup();
              groupsController.setUpdatingGroup(false);
              goBack();
            }),
      ],
    );
  }

  Widget groupPictureSection(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: groupPicture(),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          splashColor: Colors.white,
          radius: 40,
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (builder) => openSelectImageSheet(context));
          },
          child: const CircleAvatar(
            backgroundColor: Colors.black87,
            radius: 20,
            child: Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  CircleAvatar groupPicture() {
    return CircleAvatar(
        radius: 45,
        backgroundColor: Colors.black87,
        child: Observer(builder: (context) {
          XFile? picture = controller.selectedFile;
          String imageUrl = controller.group.imageUrl;
          ImageProvider? imageProvider;

          if (picture == null) {
            if (imageUrl != "") {
              imageProvider = NetworkImage(imageUrl);
            }
          } else {
            imageProvider = FileImage(File(picture.path));
          }

          return CircleAvatar(
            backgroundColor: Colors.black87,
            backgroundImage: imageProvider,
            radius: 40,
            child: (picture == null && imageUrl == "")
                ? const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 55,
                  )
                : null,
          );
        }));
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
        Observer(builder: (context) {
          List<Contact> selectedContacts = controller.selectedContacts;
          if (selectedContacts.isEmpty) {
            return MessageCard(
              appLocalizations.addParticipantsTip,
              height: 110,
            );
          } else {
            return Container();
          }
        }),
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
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                border: Border.all(color: Colors.black)),
            height: MediaQuery.of(context).size.height * .6,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [bottomSheetHeader(context), bottomSheetContactList()],
            )),
          );
        });
  }

  Widget bottomSheetContactList() {
    return Builder(builder: (context) {
      List<Contact> contacts = controller.allContacts;
      List<Contact> selectedContacts = controller.selectedContacts;
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: contacts.length,
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Observer(builder: (context) {
                  bool selected = selectedContacts.contains(contacts[index]);
                  return CreateGroupContactTile(
                    contact: contacts[index],
                    selected: selected,
                    iconAction: () {
                      if (selectedContacts.contains(contacts[index])) {
                        controller.removeContact(contacts[index]);
                      } else {
                        controller.addContact(contacts[index]);
                      }
                    },
                    selectedIcon: Icons.delete_outline,
                    unselectedIcon: Icons.add_circle_outline,
                  );
                }),
              ));
    });
  }

  Widget bottomSheetHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appLocalizations.addParticipants,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          CustomTextButton(
              text: appLocalizations.done,
              onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }

  Widget participantsSection(BuildContext context) {
    return Observer(builder: (context) {
      List<Contact> selectedContacts = controller.selectedContacts;
      if (selectedContacts.isEmpty) {
        return Container();
      } else {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: selectedContacts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CreateGroupContactTile(
                  contact: selectedContacts[index],
                  iconAction: () =>
                      controller.removeContact(selectedContacts[index]),
                  selected: true,
                  unselectedIcon: Icons.add_circle,
                  selectedIcon: Icons.delete_outline,
                ),
              );
            });
      }
    });
  }

  Widget openSelectImageSheet(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          Text(appLocalizations.chooseProfileFoto,
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton.icon(
                onPressed: () {
                  controller.getFromSource(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: Colors.black87,
                ),
                label: Text(
                  appLocalizations.camera,
                  style: const TextStyle(color: Colors.black87),
                )),
            TextButton.icon(
                onPressed: () {
                  controller.getFromSource(ImageSource.gallery);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.image,
                  size: 30,
                  color: Colors.black87,
                ),
                label: Text(
                  appLocalizations.gallery,
                  style: const TextStyle(color: Colors.black87),
                )),
          ])
        ]));
  }

  void goBack() {
    GroupsController groupsController = GetIt.I.get<GroupsController>();
    groupsController.setEditGroup(false);
    groupsController.setSelectedGroup(null);
  }
}
