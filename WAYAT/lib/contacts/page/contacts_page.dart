import 'package:flutter/material.dart';
import 'package:wayat/contacts/mock/contacts_mock.dart';
import 'package:wayat/contacts/widgets/contact_tile.dart';
import 'package:wayat/domain/contact.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        sectionTitle("Available Contacts"),
        contactList(ContactsMock.availableContacts()),
        divider(),
        sectionTitle("Unavailable Contacts"),
        contactList(ContactsMock.unavailableContacts()),
        divider(),
        sectionTitle("Not in Wayat")
      ],
    ));
  }

  ListView contactList(List<Contact> contacts) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: ((context, index) =>
            ContactTile(contact: contacts[index])));
  }

  Divider divider() {
    return const Divider(
      endIndent: 15,
      indent: 15,
      height: 1,
      thickness: 1,
    );
  }

  Padding sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Text(title),
    );
  }
}
