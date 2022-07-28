import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/navigation/app_router.gr.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  const ContactTile({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return Column(
      children: [
        ListTile(
          onTap: () {},
          leading: const CircleAvatar(
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
            onPressed: () {
              router.push(ContactDetailRoute(contact: contact));
            },
          ),
        ),
        Divider(thickness: 1)
      ],
    );
  }
}
