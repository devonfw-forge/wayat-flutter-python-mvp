import 'package:flutter/material.dart';
import 'package:wayat/domain/contact/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final TextButton? textAction;
  final IconButton? iconAction;
  final void Function()? onTilePressed;

  const ContactTile(
      {required this.contact,
      this.textAction,
      this.iconAction,
      this.onTilePressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double nameSpace = (textAction != null) ? 0.4 : 0.65;

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
                    radius: 13,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(contact.imageUrl)),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * nameSpace,
                  child: Text(
                    contact.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                (textAction != null) ? textAction! : Container(),
                (iconAction != null) ? iconAction! : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
