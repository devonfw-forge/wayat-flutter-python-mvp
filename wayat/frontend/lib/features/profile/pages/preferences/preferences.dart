import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/common/theme/text_style.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/features/profile/selector/profile_pages.dart';
import 'package:wayat/lang/app_localizations.dart';

class PreferencesPage extends StatelessWidget {
  PreferencesPage({Key? key}) : super(key: key);

  final ProfileState profileState = GetIt.I.get<ProfileState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _profileAppBar(),
        const SizedBox(height: 34.5),
        _buildEnableDarkThemeSwitchButton(),
        const SizedBox(height: 34.5),
        _buildLanguageButton(),
      ],
    );
  }

  Row _buildEnableDarkThemeSwitchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            appLocalizations.darkTheme,
            style: TextStyleTheme.primaryTextStyle_16,
          ),
        ),
        Observer(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSwitch(
              value: false, // change to controller.sharingLocation,
              onChanged: (newValue) {
                //controller.setSharingLocation(newValue);
              },
            ),
          );
        })
      ],
    );
  }

  Row _profileAppBar() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                InkWell(
                    onTap: () async {
                      profileState.setCurrentPage(ProfilePages.profile);
                    },
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black87, size: 25)),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Text(
                    appLocalizations.profile,
                    style: TextStyleTheme.primaryTextStyle_16,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Save changes
            },
            child: Text(
              appLocalizations.save,
              style: TextStyleTheme.saveButtonTextStyle_16,
              textAlign: TextAlign.right,
            ),
          )
        ],
      );

  Row _buildLanguageButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            appLocalizations.darkTheme,
            style: TextStyleTheme.primaryTextStyle_16,
          ),
        ),
        Row(
          children: [
            Text(
              appLocalizations.language,
              style: TextStyleTheme.primaryTextStyle_16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.black87, size: 25)),
            )
          ],
        ),
      ],
    );
  }
}
