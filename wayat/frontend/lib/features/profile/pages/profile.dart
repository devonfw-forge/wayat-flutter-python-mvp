import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/card.dart';
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
            _buildFaqInformationPart(),
          ],
        ));
  }

  Widget _buildProfilePart() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircleAvatar(
            radius: 95.0, backgroundImage: NetworkImage(contact.imageUrl)),
        const SizedBox(height: 16),
        Text(contact.name),
      ],
    );
  }

  Widget _buildShareLocationPart() {
    return Stack(
      children: [
        Text(appLocalizations.sharingLocation),
        _activeSharingLocationButton(),
        _setDoNotDisturbButton(),
        CustomCard(
            text: appLocalizations.editProfile,
            onTap: () {
              //AutoRoute to edit_profile page
            }),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.preferences,
            onTap: (
                //AutoRoute to preferences page
                ) {}),
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildFaqInformationPart() {
    return Stack(
      children: [
        Text(appLocalizations.information),
        CustomCard(
            text: appLocalizations.faqs,
            onTap: () {
              //AutoRoute to Faqs page
            }),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.terms,
            onTap: () {
              //AutoRoute to Terms page
            }),
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
              fontWeight: FontWeight.w400,
              color: ColorTheme.primaryColorTransparent,
              fontSize: 16),
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
              fontWeight: FontWeight.w400,
              color: ColorTheme.primaryColorTransparent,
              fontSize: 16),
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
