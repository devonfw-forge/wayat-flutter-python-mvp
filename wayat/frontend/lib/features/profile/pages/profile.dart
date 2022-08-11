import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wayat/common/widgets/buttons/outlined_button.dart';
import 'package:wayat/common/widgets/switch.dart';
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
        body: ListView(
          children: [
            _buildProfilePart(),
            _buildShareLocationPart(),
          ],
        ));
  }

  Widget _buildProfilePart() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 10,
            child:
                CircleAvatar(backgroundImage: NetworkImage(contact.imageUrl))),
        const SizedBox(height: 16),
        Text(contact.name),
      ],
    );
  }

  Widget _buildShareLocationPart() {
    return Stack(
      children: [
        const Text('Share location'),
        _activeSharingLocationButton(),
        _setDoNotDisturbButton(),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35),
            alignment: AlignmentDirectional.center,
            child: CustomOutlinedButton(
                text: appLocalizations.editProfile, onPressed: () {})),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35),
            alignment: AlignmentDirectional.center,
            child: CustomOutlinedButton(
                text: appLocalizations.preferences, onPressed: () {}))
      ],
    );
  }

  Row _activeSharingLocationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.sharingLocation,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 18),
        ),
        Observer(builder: (context) {
          return CustomSwitch(
            value: true, // change to controller.sharingLocation,
            onChanged: (newValue) {
              //controller.setSharingLocation(newValue);
            },
          );
        })
      ],
    );
  }

  Row _setDoNotDisturbButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.doNotDisturb,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 18),
        ),
        Observer(builder: (context) {
          return CustomSwitch(
            value: false, // change to controller.doNotDisturb,
            onChanged: (newValue) {
              //controller.setdoNotDisturb(newValue);
            },
          );
        })
      ],
    );
  }
}
