// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeState on _HomeState, Store {
  late final _$selectedContactAtom =
      Atom(name: '_HomeState.selectedContact', context: context);

  @override
  Contact? get selectedContact {
    _$selectedContactAtom.reportRead();
    return super.selectedContact;
  }

  @override
  set selectedContact(Contact? value) {
    _$selectedContactAtom.reportWrite(value, super.selectedContact, () {
      super.selectedContact = value;
    });
  }

  late final _$_HomeStateActionController =
      ActionController(name: '_HomeState', context: context);

  @override
  void setSelectedContact(Contact? newContact) {
    final _$actionInfo = _$_HomeStateActionController.startAction(
        name: '_HomeState.setSelectedContact');
    try {
      return super.setSelectedContact(newContact);
    } finally {
      _$_HomeStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedContact: ${selectedContact}
    ''';
  }
}
