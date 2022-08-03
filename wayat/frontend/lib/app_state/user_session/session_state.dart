import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'session_state.g.dart';

class SessionState = _SessionState with _$SessionState;

abstract class _SessionState with Store {

  @observable
  bool finishLoggedIn = false;

  @observable
  bool googleSignedIn = false;

  @observable
  bool phoneValidation = false;

  @observable
  bool hasDoneOnboarding = false;
  //bool get isLoggedIn => token.isEmpty;

  @action
  void doneOnBoarding() {
    hasDoneOnboarding = true;
  }

  @action
  void setGoogleSignIn(bool signedIn) {
    googleSignedIn = signedIn;
  }

  @action
  void setPhoneValidation(bool phoneValidated) {
    phoneValidation = phoneValidated;
  }

  @action
  void setFinishLoggedIn(bool finishedLoggedIn) {
    finishLoggedIn = finishedLoggedIn;
  }

  @action
  void googleLogin () {
    // TODO: CALL THE SERVICE AND PUT THE TOKEN
    setGoogleSignIn(true);
  }
}
