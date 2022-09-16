// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileState on _ProfileState, Store {
  late final _$currentPageAtom =
      Atom(name: '_ProfileState.currentPage', context: context);

  @override
  ProfileCurrentPages get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(ProfileCurrentPages value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$isAccountAtom =
      Atom(name: '_ProfileState.isAccount', context: context);

  @override
  bool get isAccount {
    _$isAccountAtom.reportRead();
    return super.isAccount;
  }

  @override
  set isAccount(bool value) {
    _$isAccountAtom.reportWrite(value, super.isAccount, () {
      super.isAccount = value;
    });
  }

  late final _$languageAtom =
      Atom(name: '_ProfileState.language', context: context);

  @override
  Language get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  @override
  set language(Language value) {
    _$languageAtom.reportWrite(value, super.language, () {
      super.language = value;
    });
  }

  late final _$localeAtom =
      Atom(name: '_ProfileState.locale', context: context);

  @override
  Locale get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$updateCurrentUserAsyncAction =
      AsyncAction('_ProfileState.updateCurrentUser', context: context);

  @override
  Future<dynamic> updateCurrentUser() {
    return _$updateCurrentUserAsyncAction.run(() => super.updateCurrentUser());
  }

  late final _$updateCurrentUserNameAsyncAction =
      AsyncAction('_ProfileState.updateCurrentUserName', context: context);

  @override
  Future<dynamic> updateCurrentUserName(String newName) {
    return _$updateCurrentUserNameAsyncAction
        .run(() => super.updateCurrentUserName(newName));
  }

  late final _$deleteCurrentUserAsyncAction =
      AsyncAction('_ProfileState.deleteCurrentUser', context: context);

  @override
  Future<dynamic> deleteCurrentUser() {
    return _$deleteCurrentUserAsyncAction.run(() => super.deleteCurrentUser());
  }

  late final _$changeLanguageAsyncAction =
      AsyncAction('_ProfileState.changeLanguage', context: context);

  @override
  Future<dynamic> changeLanguage(Language language) {
    return _$changeLanguageAsyncAction
        .run(() => super.changeLanguage(language));
  }

  late final _$_ProfileStateActionController =
      ActionController(name: '_ProfileState', context: context);

  @override
  void setCurrentPage(ProfileCurrentPages newPage) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setCurrentPage');
    try {
      return super.setCurrentPage(newPage);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocale(Locale newLocale) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setLocale');
    try {
      return super.setLocale(newLocale);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
isAccount: ${isAccount},
language: ${language},
locale: ${locale}
    ''';
  }
}
