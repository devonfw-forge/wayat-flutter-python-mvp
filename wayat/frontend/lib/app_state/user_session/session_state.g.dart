// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SessionState on _SessionState, Store {
  late final _$tokenAtom = Atom(name: '_SessionState.token', context: context);

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: '_SessionState.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
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

  late final _$_SessionStateActionController =
      ActionController(name: '_SessionState', context: context);

  @override
  void setToken(String newToken) {
    final _$actionInfo = _$_SessionStateActionController.startAction(
        name: '_SessionState.setToken');
    try {
      return super.setToken(newToken);
    } finally {
      _$_SessionStateActionController.endAction(_$actionInfo);
    }
  }

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
  String toString() {
    return '''
token: ${token},
isLoggedIn: ${isLoggedIn},
hasDoneOnboarding: ${hasDoneOnboarding}
    ''';
  }
}
