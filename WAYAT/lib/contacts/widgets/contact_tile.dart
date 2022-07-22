import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wayat/domain/contact.dart';
import 'package:wayat/navigation/app_router.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  const ContactTile({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return ListTile(
      onTap: () {},
      leading: const CircleAvatar(
          backgroundImage:
              NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d')),
      title: Text(contact.displayName),
      subtitle: Text("@${contact.username}"),
      trailing: IconButton(
        icon: const Icon(Icons.location_on_rounded),
        onPressed: () {
          router.push(ContactDetailRoute(contact: contact));
        },
      ),
    );
  }
}
