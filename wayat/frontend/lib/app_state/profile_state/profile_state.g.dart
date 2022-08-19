// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileState on _ProfileState, Store {
  late final _$isProfileAtom =
      Atom(name: '_ProfileState.isProfile', context: context);

  @override
  bool get isProfile {
    _$isProfileAtom.reportRead();
    return super.isProfile;
  }

  @override
  set isProfile(bool value) {
    _$isProfileAtom.reportWrite(value, super.isProfile, () {
      super.isProfile = value;
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

  late final _$isPrivacyAtom =
      Atom(name: '_ProfileState.isPrivacy', context: context);

  @override
  bool get isPrivacy {
    _$isPrivacyAtom.reportRead();
    return super.isPrivacy;
  }

  @override
  set isPrivacy(bool value) {
    _$isPrivacyAtom.reportWrite(value, super.isPrivacy, () {
      super.isPrivacy = value;
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

  late final _$_ProfileStateActionController =
      ActionController(name: '_ProfileState', context: context);

  @override
  void setProfile(bool setProfile) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setProfile');
    try {
      return super.setProfile(setProfile);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEditProfile(bool setEditProfile) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setEditProfile');
    try {
      return super.setEditProfile(setEditProfile);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPreferences(bool setPreferences) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setPreferences');
    try {
      return super.setPreferences(setPreferences);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFaqs(bool setFaqs) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setFaqs');
    try {
      return super.setFaqs(setFaqs);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrivacy(bool setPrivacy) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.setPrivacy');
    try {
      return super.setPrivacy(setPrivacy);
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
isProfile: ${isProfile},
isEditProfile: ${isEditProfile},
isPreferences: ${isPreferences},
isFaqs: ${isFaqs},
isPrivacy: ${isPrivacy},
isAccount: ${isAccount},
isSaved: ${isSaved}
    ''';
  }
}
