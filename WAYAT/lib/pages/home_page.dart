import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/appbar/appbar.dart';
import 'package:wayat/common/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:wayat/lang/lang_singleton.dart';

class HomePage extends StatelessWidget {
  final appLocalizations = GetIt.I.get<LangSingleton>().appLocalizations;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              appLocalizations.home,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
