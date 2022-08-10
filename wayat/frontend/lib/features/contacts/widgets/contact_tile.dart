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

    return ListTile(
      onTap: () {},
      leading: CircleAvatar(backgroundImage: NetworkImage(contact.imageUrl)),
      title: Text(contact.name),
      subtitle: Text("@${contact.name}"),
      trailing: IconButton(
        icon: const Icon(Icons.location_on_rounded),
        onPressed: () {
          router.push(ContactDetailRoute(contact: contact));
        },
      ),
    );
  }
}
