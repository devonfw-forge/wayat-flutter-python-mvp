import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:restart_app/restart_app.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/features/profile/controllers/edit_profile_controller.dart';
import 'package:wayat/features/profile/widgets/restart_ios_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/lang/language.dart';

class PreferencesPage extends StatefulWidget {
  final EditProfileController controller;
  PreferencesPage({super.key, controller})
      : controller = controller ?? EditProfileController();

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final ProfileState profileState = GetIt.I.get<ProfileState>();
  late Language? changedLanguage = profileState.language;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _profileAppBar(),
        const SizedBox(height: 34.5),
        // TODO: implement the dark mode
        // _buildEnableDarkThemeSwitchButton(),
        // const SizedBox(height: 34.5),
        _buildLanguageButton(),
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
                    onTap: () {
                      // Route to Profile main page
                      widget.controller.onPressedBackButton();
                    },
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black87, size: 24)),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Text(
                    appLocalizations.profile,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontSize: 19),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: TextButton(
              onPressed: () async {
                if (changedLanguage != profileState.language) {
                  await profileState.changeLanguage(changedLanguage!);
                  //Check platform:
                  //On Android restart App
                  if (defaultTargetPlatform == TargetPlatform.android) {
                    Restart.restartApp();
                  } else
                  //On iOS Apple ecosysstem don't allow restarting app programmatically
                  //For now solution is to show to the user InfoDialog with recomendation
                  //manually restarting iOS App
                  if (defaultTargetPlatform == TargetPlatform.iOS) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const RestartIosDialog();
                        });
                  }
                } else {
                  widget.controller.onPressedBackButton();
                }
              },
              child: Text(
                appLocalizations.save,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.primaryColor,
                    fontSize: 16),
                textAlign: TextAlign.right,
              ),
            ),
          )
        ],
      );

  Padding _buildLanguageButton() {
    final List<Language> itemList = Language.languageList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            GetIt.I.get<LangSingleton>().appLocalizations.language,
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

  Widget _languageButton(List<Language> itemList) {
    return Observer(builder: (context) {
      Language languageSelected =
          profileState.language ?? Language('English', 'en');
      return DropdownButton<Language>(
        value: (changedLanguage == null) ? languageSelected : changedLanguage,
        borderRadius: BorderRadius.circular(10),
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, size: 24),
        onChanged: (Language? language) {
          if (language != null) {
            changedLanguage = language;
            languageSelected = language;
          }
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
