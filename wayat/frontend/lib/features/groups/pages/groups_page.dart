import 'package:flutter/material.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';

class GroupsPage extends StatelessWidget {
  final GroupsController groupsController;

  GroupsPage({GroupsController? groupsController, Key? key})
      : groupsController = groupsController ?? GroupsController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
