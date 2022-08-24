import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/theme/text_style.dart';
import 'package:wayat/common/widgets/card.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/selector/profile_pages.dart';
import 'package:wayat/lang/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final ProfileState profileState = GetIt.I.get<ProfileState>();
  final LocationState locationState = GetIt.I.get<LocationState>();
  final SessionState userSession = GetIt.I.get<SessionState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(appLocalizations.profile,
              textAlign: TextAlign.left,
              style: TextStyleTheme.primaryTextStyle_16),
        ),
        const SizedBox(height: 16),
        _buildProfileImage(),
        const SizedBox(height: 16),
        Observer(builder: (context) {
          String name = userSession.currentUser!.name;
          return Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyleTheme.primaryTextStyle_22,
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
          MyUser myUser = userSession.currentUser!;
          return Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(myUser.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(100.0)),
              border: Border.all(
                color: Colors.black87,
                width: 7.0,
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
              profileState.setCurrentPage(ProfilePages.editProfile);
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
              style: TextStyleTheme.primaryTextStyle_16),
        ),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.faqs,
            onTap: () {
              profileState.setCurrentPage(ProfilePages.faqs);
            }),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.privacy,
            onTap: () {
              profileState.setCurrentPage(ProfilePages.privacy);
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
              style: TextStyleTheme.primaryTextStyle_16),
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
            appLocalizations.profileActiveLocation,
            style: TextStyleTheme.primaryTextStyle_16,
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
            style: TextStyleTheme.primaryTextStyle_16,
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
