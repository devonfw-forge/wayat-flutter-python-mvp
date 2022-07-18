import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wayat/domain/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  const ContactTile({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png')),
      title: Text(contact.displayName),
      subtitle: Text("@${contact.username}"),
      trailing: IconButton(
        icon: const Icon(Icons.location_on_rounded),
        onPressed: () {},
      ),
    );
  }
}
