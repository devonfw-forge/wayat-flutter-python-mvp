import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/common/widgets/buttons/custom_text_button.dart';
import 'package:wayat/common/widgets/loading_widget.dart';
import 'package:wayat/common/widgets/message_card.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/groups/widgets/group_tile.dart';
import 'package:wayat/lang/app_localizations.dart';

/// Main page of the groups feature. It displays the list of all the created
/// groups and a button to create a new one.
class GroupsPage extends StatelessWidget {
  final GroupsController controller = GetIt.I.get<GroupsController>();

  GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: groupsContent(context),
        onWillPop: () async {
          context.go('/contacts/friends');
          return true;
        });
  }

  Widget groupsContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: header(context)),
          const SizedBox(
            height: 15,
          ),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: groupList())
        ],
      ),
    );
  }

  Widget groupList() {
    return FutureBuilder(
        future: controller.updateGroups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }
          if (snapshot.hasData) {
            return Observer(builder: (context) {
              List<Group> groups = controller.groups;
              return (groups.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: MessageCard(
                        appLocalizations.noGroupsMessage,
                        height: 80,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5),
                          child: GroupTile(
                              group: groups[index],
                              onPressed: () {
                                controller.setSelectedGroup(groups[index]);
                                context
                                    .go('/contacts/groups/${groups[index].id}');
                              }),
                        );
                      });
            });
          } else {
            return Container();
          }
        });
  }

  Widget header(BuildContext context) {
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
                  onPressed: () => context.go('/contacts/friends')),
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
            onPressed: () {
              controller.setSelectedGroup(Group.empty());
              context.go('/contacts/groups/create');
            },
            text: appLocalizations.createGroup,
          )
        ],
      ),
    );
  }
}
