import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/google_maps_service/url_launcher_libw.dart';

class CannotLoginPage extends StatelessWidget {
  const CannotLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: CustomAppBar()),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 600,
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorTheme.secondaryColorDimmed),
            child: Column(
              children: [
                Text(
                  "Your account does not have a validated phone number.\n\nTo access wayat from the web:\n\n 1. Install wayat on your phone\n2. Set up your account from the app\n3. Log in again from the web",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextIconButton(
                      text: appLocalizations.goToGitHubReleases,
                      icon: Icons.link,
                      onPressed: () {
                        UrlLauncherLibW().launchUrl(
                            Uri.parse(appLocalizations.goToGitHubReleasesUrl));
                      },
                    ),
                    CustomTextIconButton(
                      text: appLocalizations.downloadWayat,
                      icon: Icons.download_sharp,
                      onPressed: () {
                        UrlLauncherLibW().launchUrl(
                            Uri.parse(appLocalizations.downloadWayatUrl));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          //const SizedBox(height: 30, child: VerticalDivider()),
        ],
      )),
    );
  }
}
