import 'package:flutter/material.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/features/groups/controllers/manage_group_controller/manage_group_controller.dart';

class ManageGroupPage extends StatelessWidget {
  ManageGroupController controller;
  ManageGroupPage({ManageGroupController? controller, Group? group, Key? key})
      : controller = controller ?? ManageGroupController(group: group),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
