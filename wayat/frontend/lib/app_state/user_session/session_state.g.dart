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
  MyUser? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(MyUser? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$doneOnBoardingAsyncAction =
      AsyncAction('_SessionState.doneOnBoarding', context: context);

  @override
  Future<void> doneOnBoarding() {
    return _$doneOnBoardingAsyncAction.run(() => super.doneOnBoarding());
  }

  late final _$initializeUserAsyncAction =
      AsyncAction('_SessionState.initializeUser', context: context);

  @override
  Future<dynamic> initializeUser() {
    return _$initializeUserAsyncAction.run(() => super.initializeUser());
  }

  late final _$updateCurrentUserAsyncAction =
      AsyncAction('_SessionState.updateCurrentUser', context: context);

  @override
  Future<dynamic> updateCurrentUser() {
    return _$updateCurrentUserAsyncAction.run(() => super.updateCurrentUser());
  }

  late final _$updatePhoneAsyncAction =
      AsyncAction('_SessionState.updatePhone', context: context);

  @override
  Future<bool> updatePhone(String phone) {
    return _$updatePhoneAsyncAction.run(() => super.updatePhone(phone));
  }

  late final _$updateOnboardingAsyncAction =
      AsyncAction('_SessionState.updateOnboarding', context: context);

  @override
  Future<bool> updateOnboarding() {
    return _$updateOnboardingAsyncAction.run(() => super.updateOnboarding());
  }

  late final _$_SessionStateActionController =
      ActionController(name: '_SessionState', context: context);

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
hasDoneOnboarding: ${hasDoneOnboarding},
currentUser: ${currentUser}
    ''';
  }
}
