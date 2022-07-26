import 'package:flutter/material.dart';
import 'package:wayat/features/contacts/controller/contact_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:azlistview/azlistview.dart';
import 'package:wayat/services/contact/mock/contacts_mock.dart';

class _AZContactItem extends ISuspensionBean {
  final String title;
  final String tag;

  _AZContactItem({required this.title, required this.tag});

  @override
  String getSuspensionTag() => tag;
}

class ContactsPage extends StatefulWidget {
  ContactsPage({Key? key, required this.onClickedItem}) : super(key: key);

  final List<Contact> contacts = ContactsMock.contacts;
  final ValueChanged<String> onClickedItem;

  @override
  State<ContactsPage> createState() => _ContactsPage();
}

class _ContactsPage extends State<ContactsPage> {
  List<_AZContactItem> contacts = [];

  final ContactController controller = ContactController();

  @override
  void initState() {
    super.initState();
    initList(widget.contacts);
  }

  void initList(List<Contact> contacts) {
    this.contacts = contacts
        .map((contacts) => _AZContactItem(
            title: contacts.displayName,
            tag: contacts.displayName[0].toUpperCase()))
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

  ListView contactList(List<Contact> contacts) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: ((context, index) =>
            ContactTile(contact: contacts[index])));
  }

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

  Widget _buildListItem(_AZContactItem contact) {
    final tag = contact.getSuspensionTag();
    final offstage = !contact.isShowSuspension;

    return Column(
      children: [
        Offstage(offstage: offstage, child: buildHeader(tag)),
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: ListTile(
            title: Text(contact.title),
            onTap: () => widget.onClickedItem(contact.title),
          ),
        ),
      ],
    );
  }

  Widget buildHeader(String tag) => Container(
        height: 21,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        child: Text(
          tag,
          softWrap: false,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      );
}
