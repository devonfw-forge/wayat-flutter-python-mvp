// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileState on _ProfileState, Store {
  late final _$currentUserAtom =
      Atom(name: '_ProfileState.currentUser', context: context);

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

  late final _$isEditProfileAtom =
      Atom(name: '_ProfileState.isEditProfile', context: context);

  @override
  bool get isEditProfile {
    _$isEditProfileAtom.reportRead();
    return super.isEditProfile;
  }

  @override
  set isEditProfile(bool value) {
    _$isEditProfileAtom.reportWrite(value, super.isEditProfile, () {
      super.isEditProfile = value;
    });
  }

  late final _$isPreferencesAtom =
      Atom(name: '_ProfileState.isPreferences', context: context);

  @override
  bool get isPreferences {
    _$isPreferencesAtom.reportRead();
    return super.isPreferences;
  }

  @override
  set isPreferences(bool value) {
    _$isPreferencesAtom.reportWrite(value, super.isPreferences, () {
      super.isPreferences = value;
    });
  }

  late final _$isFaqsAtom =
      Atom(name: '_ProfileState.isFaqs', context: context);

  @override
  bool get isFaqs {
    _$isFaqsAtom.reportRead();
    return super.isFaqs;
  }

  @override
  set isFaqs(bool value) {
    _$isFaqsAtom.reportWrite(value, super.isFaqs, () {
      super.isFaqs = value;
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

  late final _$isSavedAtom =
      Atom(name: '_ProfileState.isSaved', context: context);

  @override
  bool get isSaved {
    _$isSavedAtom.reportRead();
    return super.isSaved;
  }

  @override
  set isSaved(bool value) {
    _$isSavedAtom.reportWrite(value, super.isSaved, () {
      super.isSaved = value;
    });
  }

  late final _$updateCurrentUserAsyncAction =
      AsyncAction('_ProfileState.updateCurrentUser', context: context);

  @override
  Future<dynamic> updateCurrentUser() {
    return _$updateCurrentUserAsyncAction.run(() => super.updateCurrentUser());
  }

  late final _$uploadProfileImageAsyncAction =
      AsyncAction('_ProfileState.uploadProfileImage', context: context);

  @override
  Future<bool> uploadProfileImage(XFile? selectedImage) {
    return _$uploadProfileImageAsyncAction
        .run(() => super.uploadProfileImage(selectedImage));
  }

  late final _$updateProfileNameAsyncAction =
      AsyncAction('_ProfileState.updateProfileName', context: context);

  @override
  Future<bool> updateProfileName(String name) {
    return _$updateProfileNameAsyncAction
        .run(() => super.updateProfileName(name));
  }

  late final _$_ProfileStateActionController =
      ActionController(name: '_ProfileState', context: context);

  @override
  void setEditProfile(bool isEditProfile) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setEditProfile');
    try {
      return super.setEditProfile(isEditProfile);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPreferences(bool isPreferences) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setPreferences');
    try {
      return super.setPreferences(isPreferences);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProfileSaved(bool isSaved) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setProfileSaved');
    try {
      return super.setProfileSaved(isSaved);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isEditProfile: ${isEditProfile},
isPreferences: ${isPreferences},
isFaqs: ${isFaqs},
isAccount: ${isAccount},
isSaved: ${isSaved}
    ''';
  }
}
