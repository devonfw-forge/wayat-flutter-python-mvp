import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/location_state/share_location/share_location_state.dart';
import 'package:wayat/features/profile/controllers/profile_controller.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/app_state/user_state/user_state.dart';
import 'package:wayat/common/widgets/custom_card.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/user/my_user.dart';
import 'package:wayat/features/profile/controllers/profile_current_pages.dart';
import 'package:wayat/features/profile/widgets/delete_account_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

class ProfilePage extends StatelessWidget {
  final PlatformService platformService;
  ProfilePage({PlatformService? platformService, Key? key})
      : platformService = platformService ?? PlatformService(),
        super(key: key);

  final ProfileController profileController = GetIt.I.get<ProfileController>();
  final ShareLocationState shareLocationState =
      GetIt.I.get<LocationListener>().shareLocationState;
  final UserState userState = GetIt.I.get<UserState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (platformService.isMobile)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(appLocalizations.profile,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontSize: 16))),
          const SizedBox(height: 16),
          _buildProfileImage(),
          const SizedBox(height: 16),
          Observer(builder: (_) {
            if (userState.currentUser == null) return const Text("");
            String name = userState.currentUser!.name;
            return Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 22),
            );
          }),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const SizedBox(height: 32),
                _buildShareLocationPart(),
                const Divider(),
                const SizedBox(height: 20),
                _buildAccountPart(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Observer(builder: (context) {
          if (userState.currentUser == null) return Container();
          MyUser myUser = userState.currentUser!;
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
              profileController.currentPage = ProfileCurrentPages.editProfile;
            }),
        const SizedBox(height: 24),
        CustomCard(
            text: appLocalizations.preferences,
            onTap: () {
              profileController.currentPage = ProfileCurrentPages.preference;
            }),
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
              userState.logOut();
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
        const SizedBox(height: 24),
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
              value: shareLocationState.shareLocationEnabled,
              onChanged: (newValue) {
                shareLocationState.setShareLocationEnabled(newValue);
              },
            ),
          );
        })
      ],
    );
  }
}
