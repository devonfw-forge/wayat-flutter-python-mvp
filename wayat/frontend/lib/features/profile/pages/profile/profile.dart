import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/card.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/lang/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final ProfileState profileState = GetIt.I.get<ProfileState>();
  final LocationState locationState = GetIt.I.get<LocationState>();
  final SessionState userSession = GetIt.I.get<SessionState>();

  @observable
  String name = GetIt.I.get<SessionState>().currentUser!.name;

  @observable
  String imageUrl = GetIt.I.get<SessionState>().currentUser!.imageUrl;

  TextStyle _textStyle(Color color, double size) =>
      TextStyle(fontWeight: FontWeight.w500, color: color, fontSize: size);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(appLocalizations.profile,
              textAlign: TextAlign.left, style: _textStyle(Colors.black87, 16)),
        ),
        const SizedBox(height: 16),
        _buildProfileImage(),
        const SizedBox(height: 16),
        Observer(builder: (context) {
          return Text(
            name,
            textAlign: TextAlign.center,
            style: _textStyle(Colors.black87, 22),
          );
        }),
        const SizedBox(height: 32),
        _buildShareLocationPart(),
        const SizedBox(height: 48),

        //TODO: Implement the Information part
        // _buildInformationPart(),
        // const SizedBox(height: 48),

        //TODO: Implement the Account part
        // _buildAccountPart(),
        // const SizedBox(height: 42),
      ],
    );
  }

  //Build UI for Profile Circle Image
  Widget _buildProfileImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Observer(builder: (context) {
          return Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
              border: Border.all(
                color: Colors.black87,
                width: 5.0,
              ),
            ),
          );
        }),
      ],
    );
  }

  //Build UI for "Share Location" part
  /// - "Active location" text + Switch button
  /// - "Set do not disturb" text + Switch button
  /// - "Edit profile" custom button
  /// - "Preferences" custom button
  Widget _buildShareLocationPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(appLocalizations.sharingLocation,
              textAlign: TextAlign.left, style: _textStyle(Colors.black87, 16)),
        ),
        const SizedBox(height: 16),
        _activeSharingLocationButton(),
        const SizedBox(height: 24),

        //TODO: Implement the "Set do not disturb" switch button functional
        // _setDoNotDisturbButton(),

        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.editProfile,
            onTap: () {
              profileState.setProfile(false);
              profileState.setEditProfile(true);
              profileState.setPreferences(false);
              profileState.setFaqs(false);
              profileState.setPrivacy(false);
            }),
        const SizedBox(height: 24),

        //TODO: Implement the Preferences page
        // CustomCard(
        //     text: appLocalizations.preferences,
        //     onTap: () {
        //       controller.setPreferences(true);
        //     }),
      ],
    );
  }

  //Build UI for "Information" part
  /// - "FAQS" custom button
  /// - "Privacy" custom button
  Widget _buildInformationPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(appLocalizations.information,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 16)),
        ),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.faqs,
            onTap: () {
              profileState.setProfile(false);
              profileState.setEditProfile(false);
              profileState.setPreferences(false);
              profileState.setFaqs(true);
              profileState.setPrivacy(false); //TODO: Implement the FAQS page
            }),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.privacy,
            onTap: () {
              profileState.setProfile(false);
              profileState.setEditProfile(false);
              profileState.setPreferences(false);
              profileState.setFaqs(false);
              profileState.setPrivacy(true); //TODO: Implement the Privacy page
            }),
      ],
    );
  }

  //Build UI for "Account" part
  /// - "Log Out" custom button
  /// - "Delete Account" custom button
  Widget _buildAccountPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(appLocalizations.account,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 16)),
        ),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.logOut,
            onTap: () {
              // TODO: Implement the Log Out functional
              userSession.logOut();
            }),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.deleteAccount,
            onTap: () {
              // TODO: Implement Delete account
            }),
      ],
    );
  }

  // Build "Active sharing location" switch button
  Row _activeSharingLocationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            appLocalizations.activeSharingLocation,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
        ),
        Observer(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSwitch(
              value: locationState.shareLocationEnabled,
              onChanged: (newValue) {
                locationState.setShareLocationEnabled(newValue);
              },
            ),
          );
        })
      ],
    );
  }

  // Build "Set do not disturb" switch button
  Row _setDoNotDisturbButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            appLocalizations.doNotDisturb,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
        ),
        Observer(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSwitch(
              value: false, // change to controller.doNotDisturb,
              onChanged: (newValue) {
                //controller.setdoNotDisturb(newValue);
              },
            ),
          );
        })
      ],
    );
  }
}
