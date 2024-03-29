import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';

/// [Contact] tile displayed when editing or adding members to the Group.
///
/// Receives the [Contact] to display, the callback when tapping the [IconButton],
/// whether the tile is selected or unselected and the [IconData] for both the
/// selected and unselected state.
class CreateGroupContactTile extends StatelessWidget {
  final Contact contact;
  final Function()? iconAction;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final void Function()? onTilePressed;
  final bool selected;

  const CreateGroupContactTile(
      {required this.contact,
      this.iconAction,
      this.onTilePressed,
      Key? key,
      required this.selectedIcon,
      required this.unselectedIcon,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double nameSpace = 0.65;

    return InkWell(
      onTap: onTilePressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
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
                          backgroundImage: NetworkImage(contact.imageUrl)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * nameSpace),
                  child: Text(
                    contact.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: iconAction,
              icon: (selected) ? Icon(selectedIcon) : Icon(unselectedIcon),
              color: ColorTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
