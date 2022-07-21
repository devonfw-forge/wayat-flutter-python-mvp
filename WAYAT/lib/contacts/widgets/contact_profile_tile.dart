import 'package:flutter/material.dart';
import 'package:wayat/domain/contact.dart';

class ContactProfileTile extends StatelessWidget {
  final Contact contact;
  const ContactProfileTile({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: 30),
      const CircleAvatar(
          backgroundImage:
              NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704ds')),
      const SizedBox(height: 8),
      Text(contact.displayName),
      const SizedBox(height: 8),
      Text("@${contact.username}"),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buttonEvent(),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 50)),
          _buttonMap(),
        ],
      ),
      Divider(thickness: 2, color: Colors.grey.shade400),
    ])));
  }

  TextButton _buttonEvent() {
    return TextButton(
        child: const Text('EVENTOS'),
        onPressed: () {
          //implement function
        });
  }

  TextButton _buttonMap() {
    return TextButton(
        child: const Text('MAPA'),
        onPressed: () {
          //implement function
        });
  }
}
