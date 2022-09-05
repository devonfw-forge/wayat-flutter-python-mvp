import 'package:flutter/material.dart';
import 'package:wayat/features/contacts/widgets/contact_profile_tile.dart';
import 'package:wayat/domain/contact/contact.dart';

class ContactDetailPage extends StatelessWidget {
  const ContactDetailPage({Key? key, required this.contact}) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          ContactProfileTile(contact: contact),
          divider(),
          SingleChildScrollView(
              child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              divider(),
              //    eventList(eventController), //Push here controller of Events
              divider(),
            ],
          )),
        ]),
      ),
    );
  }

  ListView eventList(List<Contact> events) {
    //Change Contact to Event
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: ((context, index) =>
            ContactProfileTile(contact: events[index])));
  }

  Divider divider() {
    return const Divider(
      endIndent: 15,
      indent: 15,
      height: 1,
      thickness: 1,
    );
  }
}
