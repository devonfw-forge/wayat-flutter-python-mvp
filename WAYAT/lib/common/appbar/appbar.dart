import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/appbar/switch_location.dart';
import 'package:wayat/common/appbar/profile_button.dart';
import 'package:wayat/lang/lang_singleton.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  Appbar({Key? key}) : super(key: key);

  final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: const ProfileButton(),
        backgroundColor: const Color.fromARGB(255, 98, 0, 116),
        title: Text(appLocalizations.appTitle),
        actions: const <Widget>[LocationSwitch()]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
