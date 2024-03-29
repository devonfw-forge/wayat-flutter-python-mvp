import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';
import 'package:wayat/app_state/app_config_state/app_config_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/features/profile/controllers/edit_profile_controller.dart';
import 'package:wayat/features/profile/widgets/restart_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/language.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';

class PreferencesPage extends StatefulWidget {
  final EditProfileController controller;
  final PlatformService platformService;

  PreferencesPage(
      {super.key,
      EditProfileController? controller,
      PlatformService? platformService})
      : controller = controller ?? EditProfileController(),
        platformService = platformService ?? PlatformService();

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final AppConfigState appConfigState = GetIt.I.get<AppConfigState>();
  late Language? changedLanguage = appConfigState.language;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          if (widget.platformService.isDesktopOrWeb)
            const SizedBox(
              height: 20,
            ),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: _profileAppBar()),
          const SizedBox(height: 34.5),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: _buildLanguageButton()),
        ],
      ),
    );
  }

  Row _profileAppBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              IconButton(
                  splashRadius: 24,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 24,
                  onPressed: () {
                    context.go('/profile');
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black87)),
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
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: TextButton(
            onPressed: () async {
              if (changedLanguage != appConfigState.language) {
                await appConfigState.changeLanguage(changedLanguage!);
                //Check platform:
                //On Android restart App
                if (widget.platformService.targetPlatform ==
                    TargetPlatform.android) {
                  Restart.restartApp();
                } else
                //On iOS Apple ecosysstem don't allow restarting app programmatically
                //For now solution is to show to the user InfoDialog with recomendation
                //manually restarting iOS App
                if (widget.platformService.targetPlatform ==
                        TargetPlatform.iOS ||
                    widget.platformService.isDesktopOrWeb) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const RestartDialog();
                      });
                }
              } else {
                context.go('/profile');
              }
            },
            child: Text(
              appLocalizations.save,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ColorTheme.primaryColor,
                  fontSize: 17),
              textAlign: TextAlign.right,
            ),
          ),
        )
      ],
    );
  }

  Padding _buildLanguageButton() {
    final List<Language> itemList = Language.languageList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appLocalizations.language,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 19),
          ),
          _languageButton(itemList),
        ],
      ),
    );
  }

  /// Widget that changes the language of the application
  Widget _languageButton(List<Language> itemList) {
    return Observer(builder: (context) {
      Language languageSelected =
          appConfigState.language ?? Language('English', 'en');
      return DropdownButton<Language>(
        value: (changedLanguage == null) ? languageSelected : changedLanguage,
        borderRadius: BorderRadius.circular(10),
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, size: 24),
        onChanged: (Language? language) {
          setState(() {
            if (language != null) {
              changedLanguage = language;
              languageSelected = language;
            }
          });
        },
        items: itemList
            .map<DropdownMenuItem<Language>>(
              (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Text(
                    e.name,
                    style: const TextStyle(fontSize: 19),
                  )),
            )
            .toList(),
      );
    });
  }
}
