import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wayat/contacts/mock/contacts_mock.dart';
import 'package:wayat/contacts/widgets/contact_tile.dart';
import 'package:wayat/domain/contact.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Contact> _availableContacts = ContactsMock.availableContacts();
    List<Contact> _unavailableContacts = ContactsMock.unavailableContacts();

    return Scaffold(
      appBar: AppBar(title: const Text("Title")),
      body: SingleChildScrollView(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text("Available Contacts"),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _availableContacts.length,
                itemBuilder: ((context, index) =>
                    ContactTile(contact: _availableContacts[index]))),
            const Divider(
              endIndent: 15,
              indent: 15,
              height: 1,
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text("Unavailable Contacts"),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _unavailableContacts.length,
                itemBuilder: ((context, index) =>
                    ContactTile(contact: _unavailableContacts[index]))),
            const Divider(
              endIndent: 15,
              indent: 15,
              height: 1,
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text("Not in Wayat"),
            ),
          ],
        ),
      ),
    );
  }
}
