// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStatusState on _UserStatusState, Store {
  late final _$contactsAtom =
      Atom(name: '_UserStatusState.contacts', context: context);

  @override
  List<ContactLocation> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<ContactLocation> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  late final _$locationModeAtom =
      Atom(name: '_UserStatusState.locationMode', context: context);

  @override
  ShareLocationMode get locationMode {
    _$locationModeAtom.reportRead();
    return super.locationMode;
  }

  @override
  set locationMode(ShareLocationMode value) {
    _$locationModeAtom.reportWrite(value, super.locationMode, () {
      super.locationMode = value;
    });
  }

  late final _$_UserStatusStateActionController =
      ActionController(name: '_UserStatusState', context: context);

  @override
  void setContactList(List<ContactLocation> newContacts) {
    final _$actionInfo = _$_UserStatusStateActionController.startAction(
        name: '_UserStatusState.setContactList');
    try {
      return super.setContactList(newContacts);
    } finally {
      _$_UserStatusStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocationMode(ShareLocationMode newMode) {
    final _$actionInfo = _$_UserStatusStateActionController.startAction(
        name: '_UserStatusState.setLocationMode');
    try {
      return super.setLocationMode(newMode);
    } finally {
      _$_UserStatusStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contacts: ${contacts},
locationMode: ${locationMode}
    ''';
  }
}
