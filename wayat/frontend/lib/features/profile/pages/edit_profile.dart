import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/lang/app_localizations.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../domain/contact/contact.dart';

class ProfilePage extends StatelessWidget {
  final Contact contact;
  const ProfilePage({Key? key, required this.contact}) : super(key: key);

  //late ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40), child: CustomAppBar()),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildProfileImage(),
            _nameCard(),
            _changeEmail(),
            _changePassword(),
          ],
        ));
  }

  Widget _buildProfileImage() {
    return Stack(alignment: Alignment.center, children: <Widget>[
      CircleAvatar(
          radius: 95.0, backgroundImage: NetworkImage(contact.imageUrl)),
      Positioned(
          top: 10,
          child: InkWell(
              onTap: () {},
              child: const Icon(Icons.camera_alt,
                  color: ColorTheme.primaryColorTransparent, size: 45))),
    ]);
  }

  Card _nameCard() => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(appLocalizations.name),
          Text(contact.name),
        ]),
      );

  Row _changeEmail() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appLocalizations.changeEmail,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
          Positioned(
              right: 20,
              child: InkWell(
                  onTap: () {
                    //AutoRoute to change email page
                  },
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.black87, size: 16)))
        ],
      );

  Row _changePassword() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appLocalizations.changeEmail,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
          Positioned(
              right: 20,
              child: InkWell(
                  onTap: () {
                    //AutoRoute to change password page
                  },
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.black87, size: 16)))
        ],
      );
}
