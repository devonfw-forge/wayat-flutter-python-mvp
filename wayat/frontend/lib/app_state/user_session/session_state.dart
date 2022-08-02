import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'session_state.g.dart';

class SessionState = _SessionState with _$SessionState;

abstract class _SessionState with Store {
  @observable
  String token = '';

  @observable
  bool isLoggedIn = false;

  @observable
  bool hasDoneOnboarding = false;
  //bool get isLoggedIn => token.isEmpty;

  @action
  void setToken(String newToken) {
    token = newToken;
    isLoggedIn = true;
    debugPrint(isLoggedIn.toString());
  }

  @action
  void doneOnBoarding() {
    hasDoneOnboarding = true;
  }
}
