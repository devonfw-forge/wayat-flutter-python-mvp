import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/profile_state/profile_state.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/features/profile/controllers/edit_profile_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:wayat/lang/language.dart';
import 'package:wayat/main.dart';

class PreferencesPage extends StatelessWidget {
  PreferencesPage({Key? key}) : super(key: key);

  final EditProfileController controller = EditProfileController();
  final ProfileState profileState = GetIt.I.get<ProfileState>();

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
                    onTap: () {
                      // Route to Profile main page
                      controller.onPressedBackButton();
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
              onPressed: () {
                // Save changes
              },
              child: Text(
                appLocalizations.save,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
      Language languageSelected = profileState.language;
      print('itemlist: ' + itemList.map((e) => e.name).toString());
      print('itemselected: ' + languageSelected.name.toString());
      return DropdownButton<Language>(
        value: languageSelected,
        borderRadius: BorderRadius.circular(10),
        dropdownColor: Colors.grey[200],
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_forward, size: 24),
        onChanged: (Language? language) async {
          if (language != null) {
            await profileState.changeLanguage(language);
            // profileState.setLocale(Locale(language.languageCode));
            MyApp.of(context)!
                .setLocale(Locale.fromSubtags(languageCode: language.languageCode));
          }
        },
        items: itemList
            .map<DropdownMenuItem<Language>>(
              (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Text(
                    e.name!,
                    style: const TextStyle(fontSize: 19),
                  )),
            )
            .toList(),
      );
    });
  }
}
