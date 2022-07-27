import 'package:flutter/material.dart';
import 'package:wayat/features/contacts/controller/contact_controller.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:azlistview/azlistview.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class _AZContactItem extends ISuspensionBean {
  final Contact contact;
  final String tag;

  _AZContactItem({required this.contact, required this.tag});

  @override
  String getSuspensionTag() => tag;
}

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key}) : super(key: key);

  final List<Contact> contacts = ContactsMock.contacts;

  @override
  State<ContactsPage> createState() => _ContactsPage();
}

class _ContactsPage extends State<ContactsPage> {
  List<_AZContactItem> contacts = ContactsMock.contacts.cast<_AZContactItem>();

  final ContactController controller = ContactController();

  @override
  void initState() {
    super.initState();
    initList(widget.contacts);
  }

//Cut first letter and sort alphabet for building section title
  void initList(List<Contact> contacts) {
    this.contacts = contacts
        .map((contacts) => _AZContactItem(
            contact: contacts, tag: contacts.displayName[0].toUpperCase()))
        .toList();

    SuspensionUtil.sortListBySuspensionTag(this.contacts);
    SuspensionUtil.setShowSuspensionStatus(this.contacts);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    controller.updateContacts();

    return AzListView(
        padding: const EdgeInsets.all(16),
        data: contacts,
        indexBarItemHeight: MediaQuery.of(context).size.height / 40,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return _buildListItem(contact);
        });
  }

//Top title as "Select contact" or "Contacts"
  Padding sectionTitle(String title) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.25,
          ),
          textAlign: TextAlign.left,
        ));
  }

//Build sorted list of contacts
  Widget _buildListItem(_AZContactItem contact) {
    final tag = contact.getSuspensionTag();
    final offstage = !contact.isShowSuspension;

    return Column(
      children: [
        Offstage(offstage: offstage, child: _buildHeader(tag)),
        Container(
            margin: const EdgeInsets.only(right: 16),
            child: ContactTile(contact: contact.contact))
      ],
    );
  }

//Build alphabet section title by first letter tag
  Widget _buildHeader(String tag) => Container(
        height: 21,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          tag,
          softWrap: false,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      );
}
