import 'package:flutter/material.dart';
import 'package:wayat/domain/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  const ContactTile({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const CircleAvatar(
          backgroundImage:
              NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d')),
      title: Text(contact.displayName),
      subtitle: Text("@${contact.username}"),
      trailing: IconButton(
        icon: const Icon(Icons.location_on_rounded),
        onPressed: () {},
      ),
    );
  }
}
