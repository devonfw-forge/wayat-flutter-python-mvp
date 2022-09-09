import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/app_state/user_session/session_state.dart';
import 'package:wayat/common/widgets/card.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/features/profile/widgets/delete_account_dialog.dart';
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
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 16)),
        ),
        const SizedBox(height: 16),
        _buildProfileImage(),
        const SizedBox(height: 16),
        Observer(builder: (_) {
          if (userSession.currentUser == null) return const Text("");
          String name = userSession.currentUser!.name;
          return Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 22),
          );
        }),
        const SizedBox(height: 32),
        _buildShareLocationPart(),
        Divider(),
        const SizedBox(height: 20),
        _buildAccountPart(context),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Observer(builder: (context) {
          if (userSession.currentUser == null) return Container();
          MyUser myUser = userSession.currentUser!;
          return Container(
            key: const Key("profile_image"),
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
          child: Text(appLocalizations.profileShareLocation,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 16)),
        ),
        const SizedBox(height: 16),
        _activeSharingLocationButton(),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.editProfile,
            onTap: () {
              profileState.setCurrentPage(ProfileCurrentPages.editProfile);
            }),
        const SizedBox(height: 24),
      ],
    );
  }

  //Build UI for "Account" part
  /// - "Log Out" custom button
  /// - "Delete Account" custom button
  Widget _buildAccountPart(BuildContext context) {
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
              userSession.logOut();
            }),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.deleteAccount,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DeleteAccountDialog();
                  });
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
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
        ),
        Observer(builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSwitch(
              key: const Key("sw_en_prof"),
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
}
