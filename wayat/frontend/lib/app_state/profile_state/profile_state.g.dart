// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileState on _ProfileState, Store {
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

  late final _$isTermsAtom =
      Atom(name: '_ProfileState.isTerms', context: context);

  @override
  bool get isTerms {
    _$isTermsAtom.reportRead();
    return super.isTerms;
  }

  @override
  set isTerms(bool value) {
    _$isTermsAtom.reportWrite(value, super.isTerms, () {
      super.isTerms = value;
    });
  }

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

  late final _$_ProfileStateActionController =
      ActionController(name: '_ProfileState', context: context);

  @override
  void goToProfile(bool isProfile) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.goToProfile');
    try {
      return super.goToProfile(isProfile);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToEditProfile(bool isEditProfile) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.goToEditProfile');
    try {
      return super.goToEditProfile(isEditProfile);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToPreferences(bool isPreferences) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.goToPreferences');
    try {
      return super.goToPreferences(isPreferences);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToFaqs(bool isFaqs) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.goToFaqs');
    try {
      return super.goToFaqs(isFaqs);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToTerms(bool isTerms) {
    final _$actionInfo = _$_ProfileStateActionController.startAction(
        name: '_ProfileState.goToTerms');
    try {
      return super.goToTerms(isTerms);
    } finally {
      _$_ProfileStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEditProfile: ${isEditProfile},
isPreferences: ${isPreferences},
isFaqs: ${isFaqs},
isTerms: ${isTerms},
isProfile: ${isProfile}
    ''';
  }
}
