import 'package:flutter/material.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/domain/contact/contact.dart';

class ContactProfilePage extends StatelessWidget {
  final Contact contact;

  const ContactProfilePage({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40), child: CustomAppBar()),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [mapSection(context), dataSection(context)],
      ),
    );
  }

  Widget mapSection(BuildContext context) {
    return Container();
  }

  Widget dataSection(BuildContext context) {
    return Container();
  }
}
