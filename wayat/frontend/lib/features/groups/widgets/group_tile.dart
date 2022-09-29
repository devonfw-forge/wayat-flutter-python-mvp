import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/group/group.dart';

/// Displays a [Group] in the [GroupsPage].
///
/// Receives the [Group] to display and the callback
/// to execute when the tile is pressed.
class GroupTile extends StatelessWidget {
  final Group group;
  final Function()? onPressed;

  const GroupTile({required this.group, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double nameSpace = 0.65;

    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(100))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(group.imageUrl)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * nameSpace,
                  child: Text(
                    group.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ],
            ),
            IconButton(
              splashRadius: 20,
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward),
              color: ColorTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
