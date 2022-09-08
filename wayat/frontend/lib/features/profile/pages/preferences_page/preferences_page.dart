import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path/path.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/main.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _profileAppBar(),
        const SizedBox(height: 34.5),
        // TODO: implement the dark mode
        // _buildEnableDarkThemeSwitchButton(),
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
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 16),
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
                      // Route to Profile main page
                    },
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black87, size: 16)),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Text(
                    appLocalizations.profile,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontSize: 16),
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
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 16),
          ),
        ),
        Row(
          children: [
            Text(
              appLocalizations.language,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                  onTap: () {},
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.black87, size: 16)),
            )
          ],
        ),
      ],
    );
  }
}
