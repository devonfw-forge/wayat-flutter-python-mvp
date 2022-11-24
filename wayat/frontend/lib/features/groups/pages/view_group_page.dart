import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/basic_contact_tile.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

/// Detailed view of the [Group], accessible normally by tapping on a [GroupTile]
///
/// Gives access to the [ManageGroupPage] to edit the selectedGroup and
/// to the option to delete it.
///
// ignore: must_be_immutable
class ViewGroupPage extends StatelessWidget {
  final GroupsController groupsController = GetIt.I.get<GroupsController>();
  late Group selectedGroup = groupsController.selectedGroup!;
  final PlatformService platformService = GetIt.I.get<PlatformService>();

  ViewGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        groupsController.setSelectedGroup(null);
        return true;
      },
      child: groupViewContent(context),
    );
  }

  void goBack(BuildContext context) {
    groupsController.setSelectedGroup(null);
    context.go('/contacts/friends/groups');
  }

  Widget groupViewContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          if (platformService.isDesktopOrWeb)
            const SizedBox(
              height: 20,
            ),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: header(context)),
          Expanded(
              child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              groupInformation(),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: (platformService.isMobile)
                          ? Border.all(color: Colors.black)
                          : null),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 15),
                          child: Text(
                            appLocalizations.groupParticipants,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: selectedGroup.members.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10),
                                  child: BasicContactTile(
                                      contact: selectedGroup.members[index]),
                                )),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => goBack(context),
              icon: const Icon(Icons.arrow_back),
              splashRadius: 20,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75),
              child: Text(
                key: const Key("GroupNameHeader"),
                selectedGroup.name,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        popUpMenu(context)
      ],
    );
  }

  /// Menu that gives the options to edit and delete [selectedGroup]
  Widget popUpMenu(BuildContext context) {
    const int editGroup = 0;
    const int deleteGroup = 1;

    return PopupMenuButton(
      padding: const EdgeInsets.all(0),
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: ColorTheme.secondaryColor)),
      offset: const Offset(-20, 40),
      icon: const Icon(
        Icons.more_vert,
        color: ColorTheme.primaryColor,
      ),
      splashRadius: 20,
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: editGroup,
          height: 25,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(appLocalizations.editGroup),
        ),
        PopupMenuItem(
            value: deleteGroup,
            height: 25,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(appLocalizations.deleteGroup))
      ],
      onSelected: (value) {
        if (value == editGroup) {
          context.go(
              '/contacts/friends/groups/${groupsController.selectedGroup?.id}/edit');
        } else if (value == deleteGroup) {
          groupsController
              .deleteGroup(selectedGroup)
              .then((_) => groupsController.updateGroups());
          goBack(context);
        }
      },
    );
  }

  Widget groupInformation() {
    return Column(
      children: [
        (selectedGroup.imageUrl != "") ? groupPicture() : Container(),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            key: const Key("GroupNameInfo"),
            selectedGroup.name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget groupPicture() {
    return CircleAvatar(
      radius: 45,
      backgroundColor: Colors.black87,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.black,
        backgroundImage: NetworkImage(selectedGroup.imageUrl),
      ),
    );
  }
}
