import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final bool selected;
  final void Function() onButtonTap;

  const ContactTile(
      {Key? key,
      required this.contact,
      required this.selected,
      required this.onButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: (selected)
              ? Stack(
                  alignment: Alignment.center,
                  children: const [
                    CircleAvatar(backgroundColor: ColorTheme.primaryColor),
                    Icon(
                      Icons.done,
                      color: Colors.white,
                    )
                  ],
                )
              : const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?u=a042581f4e29026704d')),
          title: Text(
            contact.displayName,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.25,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: onButtonTap,
          ),
        ),
        const Divider(thickness: 1)
      ],
    );
  }
}
