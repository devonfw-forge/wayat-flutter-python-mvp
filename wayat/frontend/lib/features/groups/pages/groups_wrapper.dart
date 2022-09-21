import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class GroupsWrapper extends StatelessWidget {
  final GroupsController controller = GetIt.I.get<GroupsController>();

  GroupsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      Group? selectedGroup = controller.selectedGroup;
      bool editGroup = controller.editGroup;
      bool updatingGroup = controller.updatingGroup;
      return AutoRouter.declarative(
          routes: (_) => [
                GroupsRoute(),
                if (selectedGroup != null) ViewGroupRoute(),
                if (selectedGroup != null &&
                    (selectedGroup == Group.empty() || editGroup))
                  ManageGroupRoute(group: selectedGroup),
                if (updatingGroup) const LoadingGroupRoute()
              ]);
    });
  }
}
