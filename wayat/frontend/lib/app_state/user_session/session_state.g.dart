// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SessionState on _SessionState, Store {
  late final _$finishLoggedInAtom =
      Atom(name: '_SessionState.finishLoggedIn', context: context);

  @override
  bool get finishLoggedIn {
    _$finishLoggedInAtom.reportRead();
    return super.finishLoggedIn;
  }

  @override
  set finishLoggedIn(bool value) {
    _$finishLoggedInAtom.reportWrite(value, super.finishLoggedIn, () {
      super.finishLoggedIn = value;
    });
  }

  late final _$googleSignedInAtom =
      Atom(name: '_SessionState.googleSignedIn', context: context);

  @override
  bool get googleSignedIn {
    _$googleSignedInAtom.reportRead();
    return super.googleSignedIn;
  }

  @override
  set googleSignedIn(bool value) {
    _$googleSignedInAtom.reportWrite(value, super.googleSignedIn, () {
      super.googleSignedIn = value;
    });
  }

  late final _$phoneValidationAtom =
      Atom(name: '_SessionState.phoneValidation', context: context);

  @override
  bool get phoneValidation {
    _$phoneValidationAtom.reportRead();
    return super.phoneValidation;
  }

  @override
  set phoneValidation(bool value) {
    _$phoneValidationAtom.reportWrite(value, super.phoneValidation, () {
      super.phoneValidation = value;
    });
  }

  late final _$hasDoneOnboardingAtom =
      Atom(name: '_SessionState.hasDoneOnboarding', context: context);

  @override
  bool get hasDoneOnboarding {
    _$hasDoneOnboardingAtom.reportRead();
    return super.hasDoneOnboarding;
  }

  @override
  set hasDoneOnboarding(bool value) {
    _$hasDoneOnboardingAtom.reportWrite(value, super.hasDoneOnboarding, () {
      super.hasDoneOnboarding = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: '_SessionState.currentUser', context: context);

  @override
  User get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$googleLoginAsyncAction =
      AsyncAction('_SessionState.googleLogin', context: context);

  @override
  Future<void> googleLogin() {
    return _$googleLoginAsyncAction.run(() => super.googleLogin());
  }

  late final _$finishLoginProcessAsyncAction =
      AsyncAction('_SessionState.finishLoginProcess', context: context);

  @override
  Future<void> finishLoginProcess(GoogleAuthService googleAuth) {
    return _$finishLoginProcessAsyncAction
        .run(() => super.finishLoginProcess(googleAuth));
  }

  late final _$_SessionStateActionController =
      ActionController(name: '_SessionState', context: context);

  @override
  void doneOnBoarding() {
    final _$actionInfo = _$_SessionStateActionController.startAction(
        name: '_SessionState.doneOnBoarding');
    try {
      return super.doneOnBoarding();
    } finally {
      _$_SessionStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGoogleSignIn(bool signedIn) {
    final _$actionInfo = _$_SessionStateActionController.startAction(
        name: '_SessionState.setGoogleSignIn');
    try {
      return super.setGoogleSignIn(signedIn);
    } finally {
      _$_SessionStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneValidation(bool phoneValidated) {
    final _$actionInfo = _$_SessionStateActionController.startAction(
        name: '_SessionState.setPhoneValidation');
    try {
      return super.setPhoneValidation(phoneValidated);
    } finally {
      _$_SessionStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFinishLoggedIn(bool finishedLoggedIn) {
    final _$actionInfo = _$_SessionStateActionController.startAction(
        name: '_SessionState.setFinishLoggedIn');
    try {
      return super.setFinishLoggedIn(finishedLoggedIn);
    } finally {
      _$_SessionStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
finishLoggedIn: ${finishLoggedIn},
googleSignedIn: ${googleSignedIn},
phoneValidation: ${phoneValidation},
hasDoneOnboarding: ${hasDoneOnboarding},
currentUser: ${currentUser}
    ''';
  }
}
