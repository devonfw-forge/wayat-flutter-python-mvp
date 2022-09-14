import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/basic_contact_tile.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/lang/app_localizations.dart';

// ignore: must_be_immutable
class ViewGroupPage extends StatelessWidget {
  final GroupsController groupsController = GetIt.I.get<GroupsController>();
  late Group selectedGroup = groupsController.selectedGroup!;

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

  Widget groupViewContent(BuildContext context) {
    return Column(
      children: [
        header(),
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
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    border: Border.all(color: Colors.black)),
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
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => groupsController.setSelectedGroup(null),
              icon: const Icon(Icons.arrow_back),
              splashRadius: 20,
            ),
            Text(
              key: const Key("GroupNameHeader"),
              selectedGroup.name,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            )
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, color: ColorTheme.primaryColor),
          splashRadius: 20,
        ),
      ],
    );
  }

  Widget groupInformation() {
    return Column(
      children: [
        groupPicture(),
        const SizedBox(
          height: 15,
        ),
        Text(
          key: const Key("GroupNameInfo"),
          selectedGroup.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
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
        backgroundImage: NetworkImage(selectedGroup.imageUrl),
      ),
    );
  }
}
