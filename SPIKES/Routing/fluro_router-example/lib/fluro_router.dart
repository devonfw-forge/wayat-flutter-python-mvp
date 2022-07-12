import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_fluro_router/pages/home_page.dart';
import 'package:test_fluro_router/pages/page_two.dart';

class Routes {
  static final router = FluroRouter();

  static var homeScreen = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const HomePage();
  });

  static var pagetwoScreen = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const PageTwo();
  });
  static dynamic defineRoutes() {
    router.define("home",
        handler: homeScreen, transitionType: TransitionType.inFromBottom);
    router.define("pagetwo",
        handler: pagetwoScreen, transitionType: TransitionType.fadeIn);
  }
}
