import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class RequestErrorHandlerLibW {
  void goToErrorPage() {
    GetIt.I
        .get<GlobalKey<NavigatorState>>()
        .currentContext!
        .go('/server-error');
  }
}
