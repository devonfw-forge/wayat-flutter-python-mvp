import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/common/widgets/card.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/lang/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  final Contact contact;
  ProfilePage({Key? key, required this.contact}) : super(key: key);

  final ProfileState controller = GetIt.I.get<ProfileState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40), child: CustomAppBar()),
        body: ListView(
          children: [
            Text(appLocalizations.profile,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 16)),
            const SizedBox(height: 16),
            _buildProfilePart(),
            const SizedBox(height: 32),
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
        Text(
          contact.name,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildShareLocationPart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(appLocalizations.sharingLocation,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16)),
        _activeSharingLocationButton(),
        _setDoNotDisturbButton(),
        CustomCard(
            text: appLocalizations.editProfile,
            onTap: () async {
              controller.goToEditProfile(true);
            }),
        CustomCard(
            text: appLocalizations.preferences,
            onTap: () async {
              controller.goToPreferences(true);
            }),
      ],
    );
  }

  Widget _buildFaqInformationPart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(appLocalizations.information),
        CustomCard(
            text: appLocalizations.faqs,
            onTap: () async {
              controller.goToFaqs(true);
            }),
        CustomCard(
            text: appLocalizations.terms,
            onTap: () async {
              controller.goToTerms(true);
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
              fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 16),
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
              fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 16),
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
