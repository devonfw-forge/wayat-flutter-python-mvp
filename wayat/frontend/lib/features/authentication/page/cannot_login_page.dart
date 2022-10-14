import 'package:flutter/material.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/common/widgets/buttons/text_icon_button.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/google_maps_service/url_launcher_libw.dart';

class CannotLoginPage extends StatelessWidget {
  final UrlLauncherLibW urlLauncherLibW;

  CannotLoginPage({UrlLauncherLibW? urlLauncher, super.key})
      : urlLauncherLibW = urlLauncher ?? UrlLauncherLibW();

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
            constraints: const BoxConstraints(maxWidth: 600),
            alignment: AlignmentDirectional.center,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorTheme.secondaryColorDimmed),
            child: Column(
              children: [
                Text(
                  appLocalizations.cannotLoginMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    CustomTextIconButton(
                      text: appLocalizations.goToGitHubReleases,
                      icon: Icons.link,
                      onPressed: () {
                        urlLauncherLibW.launchUrl(
                            Uri.parse(appLocalizations.goToGitHubReleasesUrl));
                      },
                    ),
                    CustomTextIconButton(
                      text: appLocalizations.downloadWayat,
                      icon: Icons.download_sharp,
                      onPressed: () {
                        urlLauncherLibW.launchUrl(
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
